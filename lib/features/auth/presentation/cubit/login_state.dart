import 'package:equatable/equatable.dart';

enum LoginStatus {
  initial,
  submitting,
  success,
  failure,
}

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.emailError,
    this.passwordError,
    this.errorMessage,
    this.authToken,
  });

  const LoginState.initial() : this();

  final LoginStatus status;
  final String? emailError;
  final String? passwordError;
  final String? errorMessage;
  final String? authToken;

  bool get isSubmitting => status == LoginStatus.submitting;

  LoginState copyWith({
    LoginStatus? status,
    String? emailError,
    String? passwordError,
    String? errorMessage,
    String? authToken,
    bool clearEmailError = false,
    bool clearPasswordError = false,
    bool clearErrorMessage = false,
    bool clearAuthToken = false,
  }) {
    return LoginState(
      status: status ?? this.status,
      emailError: clearEmailError ? null : (emailError ?? this.emailError),
      passwordError:
          clearPasswordError ? null : (passwordError ?? this.passwordError),
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      authToken: clearAuthToken ? null : (authToken ?? this.authToken),
    );
  }

  @override
  List<Object?> get props => [
        status,
        emailError,
        passwordError,
        errorMessage,
        authToken,
      ];
}
