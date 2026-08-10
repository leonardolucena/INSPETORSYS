import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/failure_message_mapper.dart';
import 'package:inspetorsys/features/auth/domain/usecases/login_use_case.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/login_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(const LoginState.initial());

  final LoginUseCase _loginUseCase;

  void onEmailChanged() {
    if (state.emailError != null) {
      emit(state.copyWith(clearEmailError: true));
    }
  }

  void onPasswordChanged() {
    if (state.passwordError != null) {
      emit(state.copyWith(clearPasswordError: true));
    }
  }

  Future<void> submit({
    required String email,
    required String password,
  }) async {
    final validation = _validate(email: email, password: password);
    if (validation != null) {
      emit(validation);
      return;
    }

    emit(
      state.copyWith(
        status: LoginStatus.submitting,
        clearEmailError: true,
        clearPasswordError: true,
        clearErrorMessage: true,
      ),
    );

    final result = await _loginUseCase(
      email: email,
      password: password,
    );

    result.fold(
      (loginResult) => emit(
        state.copyWith(
          status: LoginStatus.success,
          authToken: loginResult.token.value,
        ),
      ),
      (failure) => emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: failure is ValidationFailure &&
                  failure.fieldErrors.isNotEmpty
              ? null
              : mapFailureToUserMessage(
                  failure,
                  context: FailureMessageContext.login,
                ),
          emailError: failure is ValidationFailure
              ? failure.fieldErrors['email']
              : null,
          passwordError: failure is ValidationFailure
              ? failure.fieldErrors['password']
              : null,
        ),
      ),
    );
  }

  LoginState? _validate({
    required String email,
    required String password,
  }) {
    final trimmedEmail = email.trim();
    final emailError =
        trimmedEmail.contains('@') ? null : 'Informe um e-mail válido';
    final passwordError = password.length >= 6
        ? null
        : 'A senha deve ter no mínimo 6 caracteres';

    if (emailError != null || passwordError != null) {
      return LoginState(
        emailError: emailError,
        passwordError: passwordError,
      );
    }

    return null;
  }
}
