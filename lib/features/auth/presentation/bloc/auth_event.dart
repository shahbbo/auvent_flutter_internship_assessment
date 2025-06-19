import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleAuthFormEvent extends AuthEvent {
  final bool isLogin;

  ToggleAuthFormEvent(this.isLogin);

  @override
  List<Object?> get props => [isLogin];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignupEvent extends AuthEvent {
  final String email;
  final String password;

  SignupEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
