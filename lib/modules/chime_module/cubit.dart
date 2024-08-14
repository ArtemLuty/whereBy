import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereby_app/api/auth_api.dart';
import 'package:whereby_app/api/chime_api.dart';
import 'package:whereby_app/api/firebase_data.dart';
import 'package:whereby_app/api/wordpress_client.dart';
import 'package:whereby_app/data_servise/data_model/weiting_room_data.dart';
import 'package:whereby_app/modules/chime_module/state.dart';

class WaitingRoomCubit extends Cubit<WaitingRoomState> {
  final AuthRepository authRepository;
  WaitingRoomCubit(
    this.authRepository,
  ) : super(const WaitingRoomState());

  void init() async {
    emit(state.copyWith(isLoading: true));
    try {
      await signInAnonymously();

      await authRepository.login(
          'voprosssik@gmail.com', '5hMlUvWvR1JC2TC1Bemxy28#');
      await Future.delayed(Duration(seconds: 2));
      final userToken = await authRepository.secureManager.getUserToken();
      final cookie = await authRepository.secureManager.getFcmToken();
      await joinAwaitingRoom('voprosssik@gmail.com', '5hMlUvWvR1JC2TC1Bemxy28#',
          userToken, cookie);

      // final user = await fetchUsers();
      final data = await fetchDataFromFirebase();
      final waitingRoomData = WaitingRoomData.fromJson(data);
      // ignore: unrelated_type_equality_checks
      final cards = await fetchCards(waitingRoomData.rooms.isNotEmpty
          ? waitingRoomData.rooms.first.cardId
          : "50f6612f-a65c-43c2-a4ca-6c33c8d348ff");
      final String logInUserId;
      logInUserId = await authRepository.secureManager.getUserId();

      print('Data from Firebase: $waitingRoomData');

      emit(state.copyWith(
          isLoading: false,
          data: waitingRoomData,
          cards: cards,
          logInUserId: logInUserId));
    } catch (e) {
      print('Error in init: $e');
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to sign in: $e'));
    }
  }

  void getSession() async {
    final userToken = await authRepository.secureManager.getUserToken();
    final cookie = await authRepository.secureManager.getFcmToken();
    await joinMeetingRoom(userToken, cookie);
  }
}
