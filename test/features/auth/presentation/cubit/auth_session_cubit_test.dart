import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/session/session_token_provider.dart';
import 'package:inspetorsys/features/auth/domain/usecases/logout_use_case.dart';
import 'package:inspetorsys/features/auth/domain/usecases/validate_session_use_case.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/auth_session_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';

class MockValidateSessionUseCase extends Mock implements ValidateSessionUseCase {}

class MockLogoutUseCase extends Mock implements LogoutUseCase {}

void main() {
  late MockTokenStorage tokenStorage;
  late SessionTokenProvider sessionTokenProvider;
  late MockValidateSessionUseCase validateSessionUseCase;
  late MockLogoutUseCase logoutUseCase;
  late AuthSessionCubit cubit;

  setUpAll(registerFallbackValues);

  setUp(() {
    tokenStorage = MockTokenStorage();
    sessionTokenProvider = SessionTokenProvider(tokenStorage);
    validateSessionUseCase = MockValidateSessionUseCase();
    logoutUseCase = MockLogoutUseCase();
    cubit = AuthSessionCubit(
      sessionTokenProvider,
      validateSessionUseCase,
      logoutUseCase,
    );

    when(() => logoutUseCase()).thenAnswer((_) async {});
  });

  tearDown(() async {
    await cubit.close();
  });

  test('initial state is unknown', () {
    expect(cubit.state, const AuthSessionState.unknown());
  });

  blocTest<AuthSessionCubit, AuthSessionState>(
    'emits unauthenticated when session validation fails',
    build: () {
      when(() => validateSessionUseCase()).thenAnswer((_) async => false);
      return AuthSessionCubit(
        sessionTokenProvider,
        validateSessionUseCase,
        logoutUseCase,
      );
    },
    act: (cubit) => cubit.checkSession(),
    expect: () => [const AuthSessionState.unauthenticated()],
    verify: (_) {
      verify(() => validateSessionUseCase()).called(1);
    },
  );

  blocTest<AuthSessionCubit, AuthSessionState>(
    'emits authenticated when session validation succeeds',
    build: () {
      when(() => validateSessionUseCase()).thenAnswer((_) async => true);
      return AuthSessionCubit(
        sessionTokenProvider,
        validateSessionUseCase,
        logoutUseCase,
      );
    },
    act: (cubit) => cubit.checkSession(),
    expect: () => [const AuthSessionState.authenticated()],
  );

  blocTest<AuthSessionCubit, AuthSessionState>(
    'signIn saves token and emits authenticated',
    build: () {
      when(() => tokenStorage.writeToken(any())).thenAnswer((_) async {});
      return AuthSessionCubit(
        sessionTokenProvider,
        validateSessionUseCase,
        logoutUseCase,
      );
    },
    act: (cubit) => cubit.signIn('token-abc'),
    expect: () => [const AuthSessionState.authenticated()],
    verify: (_) {
      verify(() => tokenStorage.writeToken('token-abc')).called(1);
    },
  );

  blocTest<AuthSessionCubit, AuthSessionState>(
    'signOut runs logout use case and emits unauthenticated',
    build: () {
      return AuthSessionCubit(
        sessionTokenProvider,
        validateSessionUseCase,
        logoutUseCase,
      );
    },
    seed: () => const AuthSessionState.authenticated(),
    act: (cubit) => cubit.signOut(),
    expect: () => [const AuthSessionState.unauthenticated()],
    verify: (_) {
      verify(() => logoutUseCase()).called(1);
    },
  );
}
