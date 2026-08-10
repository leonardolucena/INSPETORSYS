import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/features/auth/domain/entities/auth_token.dart';
import 'package:inspetorsys/features/auth/domain/entities/login_result.dart';
import 'package:inspetorsys/features/auth/domain/entities/user.dart';
import 'package:inspetorsys/features/auth/domain/usecases/login_use_case.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/login_cubit.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/login_state.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

const loginResult = LoginResult(
  token: AuthToken(value: 'token-123'),
  user: User(
    id: 'user_1',
    name: 'Inspetor',
    email: 'inspetor@example.com',
  ),
);

void main() {
  late MockLoginUseCase loginUseCase;
  late LoginCubit cubit;

  setUp(() {
    loginUseCase = MockLoginUseCase();
    cubit = LoginCubit(loginUseCase);
  });

  tearDown(() => cubit.close());

  blocTest<LoginCubit, LoginState>(
    'validates email and password before submitting',
    build: () => cubit,
    act: (cubit) => cubit.submit(
      email: 'invalido',
      password: '123',
    ),
    expect: () => [
      const LoginState(
        emailError: 'Informe um e-mail válido',
        passwordError: 'A senha deve ter no mínimo 6 caracteres',
      ),
    ],
    verify: (_) {
      verifyNever(
        () => loginUseCase(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      );
    },
  );

  blocTest<LoginCubit, LoginState>(
    'emits success when login succeeds',
    build: () {
      when(
        () => loginUseCase(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => appSuccess(loginResult));
      return cubit;
    },
    act: (cubit) => cubit.submit(
      email: 'inspetor@example.com',
      password: '123456',
    ),
    expect: () => [
      const LoginState(status: LoginStatus.submitting),
      const LoginState(
        status: LoginStatus.success,
        authToken: 'token-123',
      ),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'maps unauthorized failure to login message',
    build: () {
      when(
        () => loginUseCase(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => appFailure(const UnauthorizedFailure()));
      return cubit;
    },
    act: (cubit) => cubit.submit(
      email: 'inspetor@example.com',
      password: '123456',
    ),
    expect: () => [
      const LoginState(status: LoginStatus.submitting),
      const LoginState(
        status: LoginStatus.failure,
        errorMessage: 'E-mail ou senha inválidos.',
      ),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'maps validation failure to field errors',
    build: () {
      when(
        () => loginUseCase(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => appFailure(
          const ValidationFailure(
            message: 'Dados inválidos.',
            fieldErrors: {
              'email': 'Informe um e-mail válido.',
              'password': 'A senha deve ter no mínimo 6 caracteres.',
            },
          ),
        ),
      );
      return cubit;
    },
    act: (cubit) => cubit.submit(
      email: 'inspetor@example.com',
      password: '123456',
    ),
    expect: () => [
      const LoginState(status: LoginStatus.submitting),
      const LoginState(
        status: LoginStatus.failure,
        emailError: 'Informe um e-mail válido.',
        passwordError: 'A senha deve ter no mínimo 6 caracteres.',
      ),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'maps network failure to readable message',
    build: () {
      when(
        () => loginUseCase(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => appFailure(
          const NetworkFailure(
            'Sem conexão com a internet. Verifique sua rede e tente novamente.',
          ),
        ),
      );
      return cubit;
    },
    act: (cubit) => cubit.submit(
      email: 'inspetor@example.com',
      password: '123456',
    ),
    expect: () => [
      const LoginState(status: LoginStatus.submitting),
      const LoginState(
        status: LoginStatus.failure,
        errorMessage:
            'Sem conexão com a internet. Verifique sua rede e tente novamente.',
      ),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'clears email error when email changes',
    build: () => cubit,
    seed: () => const LoginState(emailError: 'Informe um e-mail válido'),
    act: (cubit) => cubit.onEmailChanged(),
    expect: () => [const LoginState()],
  );

  blocTest<LoginCubit, LoginState>(
    'clears password error when password changes',
    build: () => cubit,
    seed: () => const LoginState(
      passwordError: 'A senha deve ter no mínimo 6 caracteres',
    ),
    act: (cubit) => cubit.onPasswordChanged(),
    expect: () => [const LoginState()],
  );
}
