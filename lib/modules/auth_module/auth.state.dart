// abstract class AuthState {}

// class AuthInitial extends AuthState {}

// class LoginSuccess extends AuthState {
//   // final response;
//   // final chekIsOobording;
//   LoginSuccess(
//       // this.response, this.chekIsOobording
//       );
// }

// // class LoginFailure extends AuthState {
// //   // final response;

// //   LoginFailure(this.response);
// // }
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}
