import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereby_app/data_servise/repository/auth_repository.dart';
import 'package:whereby_app/api/chime_api.dart';
import 'package:whereby_app/api/firebase_data.dart';
import 'package:whereby_app/api/wordpress_client.dart';
import 'package:whereby_app/data_servise/data_model/weiting_room_data.dart';
import 'package:whereby_app/modules/chime_module/chime_cubit/chime_state.dart';

class WaitingRoomCubit extends Cubit<WaitingRoomState> {
  final AuthRepository authRepository;
  final DatabaseReference database;
  StreamSubscription? cardIdSubscription;

  WaitingRoomCubit(this.authRepository, this.database)
      : super(const WaitingRoomState());

  void init() async {
    emit(state.copyWith(isLoading: true));
    try {
      final userToken = await authRepository.secureManager.getUserToken();
      final cookie = await authRepository.secureManager.getFcmToken();
      await joinAwaitingRoom(userToken, cookie);
      final logInUserId = await authRepository.secureManager.getUserId();
      await updatePresenceStatus(userToken, true, logInUserId);
      final data = await fetchDataFromFirebase();
      final waitingRoomData = WaitingRoomData.fromJson(data);

      emit(state.copyWith(
        isLoading: false,
        data: waitingRoomData,
        logInUserId: logInUserId,
      ));
      listenToUserRoomChanges(database, logInUserId, this);
      listenToCardIdChanges(
          database, waitingRoomData.users[logInUserId]!.roomId, (newCardId) {
        _onCardIdChange(newCardId);
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error in init: $e');
      }
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to sign in: $e',
      ));
    }
  }

  void workCondition() async {
    emit(state.copyWith(isLoading: true));
    try {
      final logInUserId = await authRepository.secureManager.getUserId();
      final data = await fetchDataFromFirebase();
      final waitingRoomData = WaitingRoomData.fromJson(data);
      final roomId = waitingRoomData.users[logInUserId]!.roomId;
      final userRoom = waitingRoomData.rooms[roomId];

      emit(state.copyWith(
        isLoading: false,
        data: waitingRoomData,
        logInUserId: logInUserId,
        userRoom: userRoom,
      ));

      listenToCardIdChanges(
          database, waitingRoomData.users[logInUserId]!.roomId, (newCardId) {
        _onCardIdChange(newCardId);
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error in init: $e');
      }
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to sign in: $e',
      ));
    }
  }

  Future<void> getNextCard(roomId, cardId) async {
    final userToken = await authRepository.secureManager.getUserToken();
    final cookie = await authRepository.secureManager.getFcmToken();
    await nextCards(roomId, cardId, userToken, cookie);
    workCondition();
  }

  Future<void> deleteUserFromRoom() async {
    final userToken = await authRepository.secureManager.getUserToken();
    final cookie = await authRepository.secureManager.getFcmToken();
    await deleteUserRoom(userToken, cookie);
    cleanState();
  }

  void _onCardIdChange(String newCardId) async {
    emit(state.copyWith(isLoading: true));
    try {
      final logInUserId = await authRepository.secureManager.getUserId();
      final data = await fetchDataFromFirebase();
      final waitingRoomData = WaitingRoomData.fromJson(data);
      final roomId = waitingRoomData.users[logInUserId]!.roomId;
      final userRoom = waitingRoomData.rooms[roomId];
      final currentCard = state.cards ?? [];
      final nextCards = await fetchCards(waitingRoomData.rooms.isNotEmpty
          ? waitingRoomData.rooms[roomId]?.nextCardId
          : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");
      for (var card in nextCards) {
        if (!currentCard.any((existingCard) => existingCard.id == card.id)) {
          currentCard.add(card);
        }
      }

      emit(state.copyWith(
          isLoading: false,
          data: waitingRoomData,
          cards: currentCard,
          logInUserId: logInUserId,
          userRoom: userRoom,
          showCardLoud: false));
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching new card data: $e');
      }
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to update card data: $e',
      ));
    }
  }

  void onCardButtonClick() {
    emit(state.copyWith(showCardLoud: true));
  }

  void onRoomIdChange(String roomId) {
    if (roomId.isNotEmpty) {
      getSession();
    }
  }

  void onRoomIdNull() {
    emit(const WaitingRoomState(
      readyForCall: false,
    ));
  }

  void cleanState() async {
    emit(state.copyWith(isLoading: true));
    try {
      final userToken = await authRepository.secureManager.getUserToken();
      final logInUserId = await authRepository.secureManager.getUserId();
      await updatePresenceStatus(userToken, false, logInUserId);
      await cardIdSubscription?.cancel();

      emit(const WaitingRoomState(
        isLoading: false,
        data: null,
        cards: [],
        logInUserId: null,
        meetingData: null,
        attendeeData: null,
        readyForCall: false,
        errorMessage: '',
      ));
    } catch (e) {
      if (kDebugMode) {
        print('Error in cleanState: $e');
      }
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to clean state: $e',
      ));
    }
  }

  void getSession() async {
    emit(state.copyWith(isLoading: true));
    try {
      final userToken = await authRepository.secureManager.getUserToken();
      final cookie = await authRepository.secureManager.getFcmToken();
      final logInUserId = await authRepository.secureManager.getUserId();
      final data = await fetchDataFromFirebase();
      final waitingRoomData = WaitingRoomData.fromJson(data);
      final roomId = waitingRoomData.users[logInUserId]!.roomId;
      final userRoom = waitingRoomData.rooms[roomId];
      final currentCard = state.cards ?? [];
      final cards = await fetchCards(waitingRoomData.rooms.isNotEmpty
          ? waitingRoomData.rooms[roomId]?.cardId
          : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");
      for (var card in cards) {
        if (!currentCard.any((existingCard) => existingCard.id == card.id)) {
          currentCard.add(card);
        }
      }

      final nextCards = await fetchCards(waitingRoomData.rooms.isNotEmpty
          ? waitingRoomData.rooms[roomId]?.nextCardId
          : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");

      for (var card in nextCards) {
        if (!currentCard.any((existingCard) => existingCard.id == card.id)) {
          currentCard.add(card);
        }
      }

      final responseData = await joinMeetingRoom(
        userToken,
        cookie,
      );
      const readyForCall = true;
      final Map<String, dynamic> meetingData = responseData['meeting'];
      final Map<String, dynamic> attendeeData = responseData['attendee'];

      emit(state.copyWith(
        isLoading: false,
        meetingData: meetingData,
        attendeeData: attendeeData,
        data: waitingRoomData,
        cards: currentCard,
        logInUserId: logInUserId,
        readyForCall: readyForCall,
        userRoom: userRoom,
      ));
    } catch (e) {
      if (kDebugMode) {
        print('Error in getSession: $e');
      }
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to join meeting: $e',
      ));
    }
  }

  @override
  Future<void> close() {
    cardIdSubscription?.cancel();
    return super.close();
  }
}
