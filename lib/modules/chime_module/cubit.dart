// import 'dart:async';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:whereby_app/api/auth_api.dart';
// import 'package:whereby_app/api/chime_api.dart';
// import 'package:whereby_app/api/firebase_data.dart';
// import 'package:whereby_app/api/wordpress_client.dart';
// import 'package:whereby_app/data_servise/data_model/weiting_room_data.dart';
// import 'package:whereby_app/modules/chime_module/chime_screen.dart';
// import 'package:whereby_app/modules/chime_module/state.dart';
// import 'package:whereby_app/app.dart';

// class WaitingRoomCubit extends Cubit<WaitingRoomState> {
//   final AuthRepository authRepository;
//   final DatabaseReference database;
//   StreamSubscription? cardIdSubscription;
//   // StreamSubscription? cardIdSubscription;

//   WaitingRoomCubit(this.authRepository, this.database)
//       : super(const WaitingRoomState());

//   void init() async {
//     emit(state.copyWith(isLoading: true));
//     try {
//       final userToken = await authRepository.secureManager.getUserToken();
//       final cookie = await authRepository.secureManager.getFcmToken();

//       await joinAwaitingRoom(userToken, cookie);
//       final logInUserId = await authRepository.secureManager.getUserId();
//       await updatePresenceStatus(userToken, true, logInUserId);
//       final data = await fetchDataFromFirebase();
//       final waitingRoomData = WaitingRoomData.fromJson(data);
//       final roomId = waitingRoomData.users[logInUserId]!.roomId;
//       final userRoom = waitingRoomData.rooms[roomId];
//       final cards = await fetchCards(waitingRoomData.rooms.isNotEmpty
//           ? waitingRoomData.rooms[roomId]?.cardId
//           : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");

//       emit(state.copyWith(
//         isLoading: false,
//         data: waitingRoomData,
//         cards: cards,
//         logInUserId: logInUserId,
//         userRoom: userRoom,
//       ));
//       listenToUserRoomChanges(database, logInUserId, this);
//       listenToCardIdChanges(
//           database, waitingRoomData.users[logInUserId]!.roomId, (newCardId) {
//         _onCardIdChange(newCardId);
//       });
//     } catch (e) {
//       print('Error in init: $e');
//       emit(state.copyWith(
//         isLoading: false,
//         errorMessage: 'Failed to sign in: $e',
//       ));
//     }
//   }

//   void workCondition() async {
//     emit(state.copyWith(isLoading: true));
//     try {
//       final userToken = await authRepository.secureManager.getUserToken();
//       // final cookie = await authRepository.secureManager.getFcmToken();
//       final logInUserId = await authRepository.secureManager.getUserId();
//       await updatePresenceStatus(userToken, true, logInUserId);
//       final data = await fetchDataFromFirebase();
//       final waitingRoomData = WaitingRoomData.fromJson(data);
//       final roomId = waitingRoomData.users[logInUserId]!.roomId;
//       final userRoom = waitingRoomData.rooms[roomId];
//       final cards = await fetchCards(waitingRoomData.rooms.isNotEmpty
//           ? waitingRoomData.rooms[roomId]?.cardId
//           : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");

//       emit(state.copyWith(
//         isLoading: false,
//         data: waitingRoomData,
//         cards: cards,
//         logInUserId: logInUserId,
//         userRoom: userRoom,
//       ));
//       // listenToUserRoomChanges(database, logInUserId, this);
//       // listenToCardIdChanges(
//       //     database, waitingRoomData.users[logInUserId]!.roomId, (newCardId) {
//       listenToCardIdChanges(
//           database, waitingRoomData.users[logInUserId]!.roomId, (newCardId) {
//         _onCardIdChange(newCardId);
//       });
//       // });
//     } catch (e) {
//       print('Error in init: $e');
//       emit(state.copyWith(
//         isLoading: false,
//         errorMessage: 'Failed to sign in: $e',
//       ));
//     }
//   }

//   // Listen for changes to the cardId within the room

//   Future<void> getNextCard(roomId, cardId) async {
//     final userToken = await authRepository.secureManager.getUserToken();
//     final cookie = await authRepository.secureManager.getFcmToken();
//     await nextCards(roomId, cardId, userToken, cookie);
//     workCondition();
//   }

//   Future<void> deleteUserFromRoom() async {
//     final userToken = await authRepository.secureManager.getUserToken();
//     final cookie = await authRepository.secureManager.getFcmToken();
//     await deleteUserRoom(userToken, cookie);
//     cleanState();
//   }

//   void _onCardIdChange(String newCardId) async {
//     emit(state.copyWith(isLoading: true));
//     try {
//       final userToken = await authRepository.secureManager.getUserToken();
//       final logInUserId = await authRepository.secureManager.getUserId();
//       final data = await fetchDataFromFirebase();
//       final waitingRoomData = WaitingRoomData.fromJson(data);
//       final roomId = waitingRoomData.users[logInUserId]!.roomId;
//       final userRoom = waitingRoomData.rooms[roomId];
//       final cards = await fetchCards(waitingRoomData.rooms.isNotEmpty
//           ? waitingRoomData.rooms[roomId]?.cardId
//           : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");
//       // await updatePresenceStatus(userToken, true, logInUserId);
//       emit(state.copyWith(
//         isLoading: false,
//         data: waitingRoomData,
//         cards: cards,
//         logInUserId: logInUserId,
//         userRoom: userRoom,
//       ));
//     } catch (e) {
//       print('Error fetching new card data: $e');
//       emit(state.copyWith(
//         isLoading: false,
//         errorMessage: 'Failed to update card data: $e',
//       ));
//     }
//   }

//   void onRoomIdChange(String roomId) {
//     if (roomId.isNotEmpty) {
//       getSession();
//     }
//   }

//   void onRoomIdNull() {
//     emit(WaitingRoomState(
//       readyForCall: false,
//     ));
//   }

//   void cleanState() async {
//     emit(state.copyWith(isLoading: true));
//     try {
//       final userToken = await authRepository.secureManager.getUserToken();
//       final logInUserId = await authRepository.secureManager.getUserId();
//       await updatePresenceStatus(userToken, false, logInUserId);

//       // Cancel any ongoing subscriptions
//       await cardIdSubscription?.cancel();
//       cardIdSubscription = null;

//       emit(WaitingRoomState(
//         isLoading: false,
//         data: null,
//         cards: [],
//         logInUserId: null,
//         meetingData: null,
//         attendeeData: null,
//         readyForCall: false,
//         errorMessage: '',
//       ));
//     } catch (e) {
//       print('Error in cleanState: $e');
//       emit(state.copyWith(
//         isLoading: false,
//         errorMessage: 'Failed to clean state: $e',
//       ));
//     }
//   }

//   void getSession() async {
//     emit(state.copyWith(isLoading: true));
//     try {
//       final userToken = await authRepository.secureManager.getUserToken();
//       final cookie = await authRepository.secureManager.getFcmToken();
//       final logInUserId = await authRepository.secureManager.getUserId();
//       // connectWpClients();
//       final data = await fetchDataFromFirebase();
//       final waitingRoomData = WaitingRoomData.fromJson(data);
//       final roomId = waitingRoomData.users[logInUserId]!.roomId;
//       final userRoom = waitingRoomData.rooms[roomId];
//       final cards = await fetchCards(waitingRoomData.rooms.isNotEmpty
//           ? waitingRoomData.rooms[roomId]?.cardId
//           : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");

//       final responseData = await joinMeetingRoom(
//         userToken,
//         cookie,
//       );

//       const readyForCall = true;
//       final Map<String, dynamic> meetingData = responseData['meeting'];
//       final Map<String, dynamic> attendeeData = responseData['attendee'];

//       // await updatePresenceStatus(userToken, true, logInUserId);

//       emit(state.copyWith(
//         isLoading: false,
//         meetingData: meetingData,
//         attendeeData: attendeeData,
//         data: waitingRoomData,
//         cards: cards,
//         logInUserId: logInUserId,
//         readyForCall: readyForCall,
//         userRoom: userRoom,
//       ));
//       // listenToUserRoomChanges(database, logInUserId, this);
//       // listenToCardIdChanges(
//       //     database, waitingRoomData.users[logInUserId]!.roomId, (newCardId) {
//       //   _onCardIdChange(newCardId);
//       // });
//     } catch (e) {
//       print('Error in getSession: $e');
//       emit(state.copyWith(
//         isLoading: false,
//         errorMessage: 'Failed to join meeting: $e',
//       ));
//     }
//   }

//   // @override
//   // Future<void> close() {
//   //   cardIdSubscription?.cancel();
//   //   return super.close();
//   // }
// }
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereby_app/api/auth_api.dart';
import 'package:whereby_app/api/chime_api.dart';
import 'package:whereby_app/api/firebase_data.dart';
import 'package:whereby_app/api/wordpress_client.dart';
import 'package:whereby_app/data_servise/data_model/card.dart';
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
      // final cards = await fetchCards(waitingRoomData.rooms.isNotEmpty
      //     ? waitingRoomData.rooms.first.cardId
      //     : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");
      // final nextCard = await fetchNextCards(waitingRoomData.rooms.isNotEmpty
      //     ? waitingRoomData.rooms.first.nextCardId
      //     : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");
      // cards.addAll(nextCard);

      emit(state.copyWith(
        isLoading: false,
        data: waitingRoomData,
        // cards: cards,
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
      final logInUserId = await authRepository.secureManager.getUserId();
      final data = await fetchDataFromFirebase();
      final waitingRoomData = WaitingRoomData.fromJson(data);
      final roomId = waitingRoomData.users[logInUserId]!.roomId;
      final userRoom = waitingRoomData.rooms[roomId];

      // Отримання карток для поточного стану
      // final cards = await fetchCards(waitingRoomData.rooms.isNotEmpty
      //     ? waitingRoomData.rooms[roomId]?.cardId
      //     : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");

      // // Існуючі картки з поточного стану
      // final currentCard = state.cards ?? [];

      // // Отримання наступних карток
      // final nextCards = await fetchCards(waitingRoomData.rooms.isNotEmpty
      //     ? waitingRoomData.rooms[roomId]?.nextCardId
      //     : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");

      // // Додавання нових карток до списку, уникаючи дублікатів
      // for (var card in nextCards) {
      //   if (!currentCard.any((existingCard) => existingCard.id == card.id)) {
      //     currentCard.add(card);
      //   }
      // }

      emit(state.copyWith(
        isLoading: false,
        data: waitingRoomData,
        // cards: currentCard,
        logInUserId: logInUserId,
        userRoom: userRoom,
      ));

      // Лістенер для змін ID карток
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
    print('1---------------------------');
    emit(state.copyWith(isLoading: true));
    try {
      final userToken = await authRepository.secureManager.getUserToken();
      final logInUserId = await authRepository.secureManager.getUserId();
      final data = await fetchDataFromFirebase();
      final waitingRoomData = WaitingRoomData.fromJson(data);
      final roomId = waitingRoomData.users[logInUserId]!.roomId;
      final userRoom = waitingRoomData.rooms[roomId];

      // Існуючі картки з поточного стану
      final currentCard = state.cards ?? [];

      // Отримання наступних карток
      final nextCards = await fetchCards(waitingRoomData.rooms.isNotEmpty
          ? waitingRoomData.rooms[roomId]?.nextCardId
          : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");

      // Додавання нових карток до списку, уникаючи дублікатів
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
      ));
    } catch (e) {
      print('Error fetching new card data: $e');
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to update card data: $e',
      ));
    }
  }

  // void workCondition() async {
  //   emit(state.copyWith(isLoading: true));
  //   try {
  //     final logInUserId = await authRepository.secureManager.getUserId();
  //     final data = await fetchDataFromFirebase();
  //     final waitingRoomData = WaitingRoomData.fromJson(data);
  //     final roomId = waitingRoomData.users[logInUserId]!.roomId;
  //     final userRoom = waitingRoomData.rooms[roomId];
  //     final cards = await fetchCards(waitingRoomData.rooms.isNotEmpty
  //         ? waitingRoomData.rooms[roomId]?.cardId
  //         : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");
  //     final currentCard = state.cards ?? [];
  //     final nextCards = await fetchCards(waitingRoomData.rooms.isNotEmpty
  //         ? waitingRoomData.rooms[roomId]?.nextCardId
  //         : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");
  //     currentCard.addAll(nextCards);
  //     emit(state.copyWith(
  //       isLoading: false,
  //       data: waitingRoomData,
  //       cards: currentCard,
  //       logInUserId: logInUserId,
  //       userRoom: userRoom,
  //     ));
  //     listenToCardIdChanges(
  //         database, waitingRoomData.users[logInUserId]!.roomId, (newCardId) {
  //       _onCardIdChange(newCardId);
  //     });
  //   } catch (e) {
  //     print('Error in init: $e');
  //     emit(state.copyWith(
  //       isLoading: false,
  //       errorMessage: 'Failed to sign in: $e',
  //     ));
  //   }
  // }

  // Future<void> getNextCard(roomId, cardId) async {
  //   final userToken = await authRepository.secureManager.getUserToken();
  //   final cookie = await authRepository.secureManager.getFcmToken();
  //   await nextCards(roomId, cardId, userToken, cookie);
  //   workCondition();
  // }

  // Future<void> deleteUserFromRoom() async {
  //   final userToken = await authRepository.secureManager.getUserToken();
  //   final cookie = await authRepository.secureManager.getFcmToken();
  //   await deleteUserRoom(userToken, cookie);
  //   cleanState();
  // }

  // void _onCardIdChange(String newCardId) async {
  //   print('1---------------------------');
  //   emit(state.copyWith(isLoading: true));
  //   try {
  //     final userToken = await authRepository.secureManager.getUserToken();
  //     final logInUserId = await authRepository.secureManager.getUserId();
  //     final data = await fetchDataFromFirebase();
  //     final waitingRoomData = WaitingRoomData.fromJson(data);
  //     final roomId = waitingRoomData.users[logInUserId]!.roomId;
  //     final userRoom = waitingRoomData.rooms[roomId];
  //     // final cards = await fetchCards(waitingRoomData.rooms.isNotEmpty
  //     //     ? waitingRoomData.rooms[roomId]?.cardId
  //     //     : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");
  //     final currentCard = state.cards ?? [];
  //     final nextCards = await fetchCards(waitingRoomData.rooms.isNotEmpty
  //         ? waitingRoomData.rooms[roomId]?.nextCardId
  //         : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");
  //     currentCard.addAll(nextCards);
  //     // await updatePresenceStatus(userToken, true, logInUserId);
  //     emit(state.copyWith(
  //       isLoading: false,
  //       data: waitingRoomData,
  //       cards: currentCard,
  //       logInUserId: logInUserId,
  //       userRoom: userRoom,
  //     ));
  //   } catch (e) {
  //     print('Error fetching new card data: $e');
  //     emit(state.copyWith(
  //       isLoading: false,
  //       errorMessage: 'Failed to update card data: $e',
  //     ));
  //   }
  // }

  void onRoomIdChange(String roomId) {
    if (roomId.isNotEmpty) {
      getSession();
    }
  }

  void onRoomIdNull() {
    emit(WaitingRoomState(
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

      final data = await fetchDataFromFirebase();
      final waitingRoomData = WaitingRoomData.fromJson(data);
      final roomId = waitingRoomData.users[logInUserId]!.roomId;
      final userRoom = waitingRoomData.rooms[roomId];

      // final currentCard = state.cards ?? [];
      // final nextCard = await fetchCards(waitingRoomData.rooms.isNotEmpty
      //     ? waitingRoomData.rooms[roomId]?.nextCardId
      //     : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");
      // currentCard.addAll(cards);
      // currentCard.addAll(nextCard);

      // Існуючі картки з поточного стану
      final currentCard = state.cards ?? [];

      final cards = await fetchCards(waitingRoomData.rooms.isNotEmpty
          ? waitingRoomData.rooms[roomId]?.cardId
          : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");
      for (var card in cards) {
        if (!currentCard.any((existingCard) => existingCard.id == card.id)) {
          currentCard.add(card);
        }
      }
      // Отримання наступних карток
      final nextCards = await fetchCards(waitingRoomData.rooms.isNotEmpty
          ? waitingRoomData.rooms[roomId]?.nextCardId
          : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");

      // Додавання нових карток до списку, уникаючи дублікатів
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

      // await updatePresenceStatus(userToken, true, logInUserId);

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

  @override
  Future<void> close() {
    cardIdSubscription?.cancel();
    return super.close();
  }
}
