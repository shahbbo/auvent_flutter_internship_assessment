import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.signupUseCase,
  }) : super(AuthState.initial()) {
    on<ToggleAuthFormEvent>(_toggleAuthForm);
    on<LoginEvent>(_login);
    on<SignupEvent>(_signup);
  }

  void _toggleAuthForm(ToggleAuthFormEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      formType: event.isLogin ? AuthFormType.login : AuthFormType.signup,
      errorMessage: null,
    ));
  }

  Future<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await loginUseCase(event.email, event.password);

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        ));
      },
      (user) => emit(state.copyWith(
        isLoading: false,
        user: user,
        isAuthenticated: true,
        errorMessage: null,
      )),
    );
  }

  Future<void> _signup(SignupEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await signupUseCase(event.email, event.password);

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        ));
      },
      (user) => emit(state.copyWith(
        isLoading: false,
        user: user,
        isAuthenticated: true,
        errorMessage: null,
      )),
    );
  }
}
