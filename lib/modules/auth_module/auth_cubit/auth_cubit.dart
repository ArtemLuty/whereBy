import 'package:bloc/bloc.dart';
import 'package:whereby_app/data_servise/repository/auth_repository.dart';
import 'package:whereby_app/api/firebase_data.dart';
import 'package:whereby_app/data_servise/repository/secure_storage.dart';
import 'package:whereby_app/modules/auth_module/auth_cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final SecureStorageManager secureManager;

  AuthCubit(
    this.secureManager,
    this.authRepository,
  ) : super(AuthInitial());

  Future<void> getUserToken(String login, String password) async {
    emit(AuthLoading());
    try {
      await signInAnonymously();
      await authRepository.login(login, password);
      emit(AuthSuccess());
    } catch (error) {
      emit(AuthError(error.toString()));
    }
  }
}
