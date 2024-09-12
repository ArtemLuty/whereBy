import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereby_app/data_servise/repository/user_repository.dart';
import 'package:whereby_app/modules/home_module/home_cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final UserRepository userRepository;

  HomeCubit(this.userRepository) : super(const HomeState());

  void init() {}

  Future<void> awaitingTime() async {
    try {
      emit(state.copyWith(isLoading: true));
      final meetingTime = await userRepository.joinMeetingTime();
      emit(state.copyWith(isLoading: false, meetingTime: meetingTime));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
