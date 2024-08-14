abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginSuccess extends AuthState {
  // final response;
  // final chekIsOobording;
  LoginSuccess(
      // this.response, this.chekIsOobording
      );
}

// class LoginFailure extends AuthState {
//   // final response;

//   LoginFailure(this.response);
// }
