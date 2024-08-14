import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:whereby_app/data_servise/repository/secure_storage.dart';

class AuthRepository {
  final SecureStorageManager secureManager;

  AuthRepository(this.secureManager);

  Future<void> login(
    String login,
    String password,
  ) async {
    const String loginUrl = 'https://test.wtalk.space/wp-json/user/login';

    final loginResponse = await http.post(
      Uri.parse(loginUrl),
      headers: {},
      body: {'login': login, 'password': password},
    );

    if (loginResponse.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(loginResponse.body);

      String jwtToken = responseData['token'];
      Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken);
      int userId = decodedToken['data']['user_id'];
      await secureManager.saveUserToken(jwtToken.toString());

      await secureManager.saveUserId(userId.toString());
      print('UserId: $userId');
    } else {
      print('Failed to login: ${loginResponse.statusCode}');
    }
    // Extract cookies from the login response
    final setCookie = loginResponse.headers['set-cookie'];
    await secureManager.saveFcmToken(setCookie.toString());
    if (setCookie == null) {
      print('Failed to retrieve session cookies');
      return;
    }
  }
}
