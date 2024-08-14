import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:whereby_app/api/auth_api.dart';
import 'package:whereby_app/data_servise/repository/auth_repository.dart';
import 'package:whereby_app/data_servise/repository/secure_storage.dart';
import 'package:whereby_app/modules/auth_module/auth.state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final SecureStorageManager secureManager;

  AuthCubit(
    this.secureManager,
    this.authRepository,
  ) : super(AuthInitial());

  Future<void> getUserToken() async {
    // await authRepository.userLogin();
  }

  void setQrToken(qrToken) async {
    await secureManager.saveUserToken(qrToken);
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(qrToken);
      String userId = decodedToken['drupal']['uid'].toString();
      await secureManager.saveUserId(userId);
    } catch (e) {
      if (kDebugMode) {
        print('Error decoding JWT token: $e');
      }
    }
  }
}
