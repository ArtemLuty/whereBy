class UserLoginResponse {
  final UserLoginData? response;
  final List<String>? errors;

  UserLoginResponse({this.response, this.errors});

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) {
    return UserLoginResponse(
      response: UserLoginData.fromJson(json['response']),
      errors: (json['errors'] as List<dynamic>?)
          ?.map((error) => error.toString())
          .toList(),
    );
  }
}

class UserLoginData {
  final String? token;
  final String? userId;

  UserLoginData({this.token, this.userId});

  factory UserLoginData.fromJson(Map<String, dynamic> json) {
    return UserLoginData(
      token: json['token']?.toString(),
      userId: json['user_id']?.toString(),
    );
  }
}

class UserLoginMutationResponse {
  final UserLoginResponse? userLogin;

  UserLoginMutationResponse({this.userLogin});

  factory UserLoginMutationResponse.fromJson(Map<String, dynamic> json) {
    return UserLoginMutationResponse(
      userLogin: UserLoginResponse.fromJson(json['user_login']),
    );
  }
}
