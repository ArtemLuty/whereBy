import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereby_app/api/auth_api.dart';
import 'package:whereby_app/api/chime_api.dart';
import 'package:whereby_app/api/firebase_data.dart';
import 'package:whereby_app/api/wordpress_client.dart';
import 'package:whereby_app/data_servise/data_model/weiting_room_data.dart';
import 'package:whereby_app/modules/chime_module/chime_screen.dart';
import 'package:whereby_app/modules/chime_module/state.dart';
import 'package:whereby_app/app.dart';

class WaitingRoomCubit extends Cubit<WaitingRoomState> {
  final AuthRepository authRepository;
  final DatabaseReference database;
  StreamSubscription? cardIdSubscription;
  // StreamSubscription? cardIdSubscription;

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
      final cards = await fetchCards(waitingRoomData.rooms.isNotEmpty
          ? waitingRoomData.rooms.first.cardId
          : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");

      emit(state.copyWith(
        isLoading: false,
        data: waitingRoomData,
        cards: cards,
        logInUserId: logInUserId,
      ));
      listenToUserRoomChanges(database, logInUserId, this);
      listenToCardIdChanges(
          database, waitingRoomData.users[logInUserId]!.roomId, (newCardId) {
        _onCardIdChange(newCardId);
      });
    } catch (e) {
      print('Error in init: $e');
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to sign in: $e',
      ));
    }
  }

  void workCondition() async {
    emit(state.copyWith(isLoading: true));
    try {
      final userToken = await authRepository.secureManager.getUserToken();
      // final cookie = await authRepository.secureManager.getFcmToken();
      final logInUserId = await authRepository.secureManager.getUserId();
      await updatePresenceStatus(userToken, true, logInUserId);
      final data = await fetchDataFromFirebase();
      final waitingRoomData = WaitingRoomData.fromJson(data);
      final cards = await fetchCards(waitingRoomData.rooms.isNotEmpty
          ? waitingRoomData.rooms.first.cardId
          : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");

      emit(state.copyWith(
        isLoading: false,
        data: waitingRoomData,
        cards: cards,
        logInUserId: logInUserId,
      ));
      // listenToUserRoomChanges(database, logInUserId, this);
      // listenToCardIdChanges(
      //     database, waitingRoomData.users[logInUserId]!.roomId, (newCardId) {
      listenToCardIdChanges(
          database, waitingRoomData.users[logInUserId]!.roomId, (newCardId) {
        _onCardIdChange(newCardId);
      });
      // });
    } catch (e) {
      print('Error in init: $e');
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to sign in: $e',
      ));
    }
  }

  // Listen for changes to the cardId within the room

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
      final userToken = await authRepository.secureManager.getUserToken();
      final logInUserId = await authRepository.secureManager.getUserId();
      final data = await fetchDataFromFirebase();
      final waitingRoomData = WaitingRoomData.fromJson(data);
      final cards = await fetchCards(waitingRoomData.rooms.isNotEmpty
          ? waitingRoomData.rooms.first.cardId
          : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");
      await updatePresenceStatus(userToken, true, logInUserId);
      emit(state.copyWith(
        isLoading: false,
        data: waitingRoomData,
        cards: cards,
        logInUserId: logInUserId,
      ));
    } catch (e) {
      print('Error fetching new card data: $e');
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to update card data: $e',
      ));
    }
  }

  void onRoomIdChange(String roomId) {
    if (roomId.isNotEmpty) {
      getSession();
    }
    // Trigger session update after room ID change
  }

  void cleanState() async {
    emit(state.copyWith(isLoading: true));
    try {
      final userToken = await authRepository.secureManager.getUserToken();
      final logInUserId = await authRepository.secureManager.getUserId();
      await updatePresenceStatus(userToken, false, logInUserId);

      // Cancel any ongoing subscriptions
      await cardIdSubscription?.cancel();
      cardIdSubscription = null;

      emit(WaitingRoomState(
        isLoading: false,
        data: null, // Reset to initial state
        cards: [], // Clear the cards list
        logInUserId: null, // Clear the user ID
        meetingData: null, // Clear the meeting data
        attendeeData: null, // Clear the attendee data
        readyForCall: false, // Reset the call readiness
        errorMessage: '', // Clear any error messages
      ));
    } catch (e) {
      print('Error in cleanState: $e');
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
      connectWpClients();
      final data = await fetchDataFromFirebase();
      final waitingRoomData = WaitingRoomData.fromJson(data);
      final cards = await fetchCards(waitingRoomData.rooms.isNotEmpty
          ? waitingRoomData.rooms.first.cardId
          : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");

      final responseData = await joinMeetingRoom(
        userToken,
        cookie,
      );

      const readyForCall = true;
      final Map<String, dynamic> meetingData = responseData['meeting'];
      final Map<String, dynamic> attendeeData = responseData['attendee'];

      await updatePresenceStatus(userToken, true, logInUserId);

      emit(state.copyWith(
        isLoading: false,
        meetingData: meetingData,
        attendeeData: attendeeData,
        data: waitingRoomData,
        cards: cards,
        logInUserId: logInUserId,
        readyForCall: readyForCall,
      ));
      // listenToUserRoomChanges(database, logInUserId, this);
      // listenToCardIdChanges(
      //     database, waitingRoomData.users[logInUserId]!.roomId, (newCardId) {
      //   _onCardIdChange(newCardId);
      // });
    } catch (e) {
      print('Error in getSession: $e');
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to join meeting: $e',
      ));
    }
  }

  // @override
  // Future<void> close() {
  //   cardIdSubscription?.cancel();
  //   return super.close();
  // }
}
