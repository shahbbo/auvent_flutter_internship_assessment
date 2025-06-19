import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

enum AuthFormType { login, signup }

class AuthState extends Equatable {
  final AuthFormType formType;
  final bool isLoading;
  final User? user;
  final bool isAuthenticated;
  final String? errorMessage;

  const AuthState({
    required this.formType,
    required this.isLoading,
    required this.isAuthenticated,
    this.user,
    this.errorMessage,
  });

  factory AuthState.initial() {
    return const AuthState(
      formType: AuthFormType.login,
      isAuthenticated: false,
      isLoading: false,
    );
  }

  AuthState copyWith({
    AuthFormType? formType,
    bool? isLoading,
    User? user,
    String? errorMessage,
    bool? isAuthenticated,
  }) {
    return AuthState(
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [formType, isLoading, isAuthenticated, user, errorMessage];
}
