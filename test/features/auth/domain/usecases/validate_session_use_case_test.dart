import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/core/session/session_token_provider.dart';
import 'package:inspetorsys/features/auth/domain/entities/user.dart';
import 'package:inspetorsys/features/auth/domain/repositories/auth_repository.dart';
import 'package:inspetorsys/features/auth/domain/usecases/logout_use_case.dart';
import 'package:inspetorsys/features/auth/domain/usecases/validate_session_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockLogoutUseCase extends Mock implements LogoutUseCase {}

void main() {
  late MockTokenStorage tokenStorage;
  late SessionTokenProvider sessionTokenProvider;
  late MockAuthRepository authRepository;
  late MockLogoutUseCase logoutUseCase;
  late ValidateSessionUseCase useCase;

  setUp(() {
    tokenStorage = MockTokenStorage();
    sessionTokenProvider = SessionTokenProvider(tokenStorage);
    authRepository = MockAuthRepository();
    logoutUseCase = MockLogoutUseCase();
    useCase = ValidateSessionUseCase(
      authRepository,
      sessionTokenProvider,
      logoutUseCase,
    );

    when(() => logoutUseCase()).thenAnswer((_) async {});
  });

  test('returns false when there is no stored token', () async {
    when(() => tokenStorage.readToken()).thenAnswer((_) async => null);

    final isAuthenticated = await useCase();

    expect(isAuthenticated, isFalse);
    verifyNever(() => authRepository.getCurrentUser());
    verifyNever(() => logoutUseCase());
  });

  test('returns true when /auth/me succeeds', () async {
    when(() => tokenStorage.readToken()).thenAnswer((_) async => 'token-123');
    when(() => authRepository.getCurrentUser()).thenAnswer(
      (_) async => appSuccess(
        const User(
          id: 'u_001',
          name: 'Ana Técnica',
          email: 'tecnico@orbytis.com.br',
          role: 'field_technician',
        ),
      ),
    );

    final isAuthenticated = await useCase();

    expect(isAuthenticated, isTrue);
    verify(() => authRepository.getCurrentUser()).called(1);
    verifyNever(() => logoutUseCase());
  });

  test('runs logout and returns false on 401', () async {
    when(() => tokenStorage.readToken()).thenAnswer((_) async => 'token-123');
    when(() => authRepository.getCurrentUser()).thenAnswer(
      (_) async => appFailure(const UnauthorizedFailure()),
    );

    final isAuthenticated = await useCase();

    expect(isAuthenticated, isFalse);
    verify(() => logoutUseCase()).called(1);
  });

  test('keeps authenticated on network failure for offline-first', () async {
    when(() => tokenStorage.readToken()).thenAnswer((_) async => 'token-123');
    when(() => authRepository.getCurrentUser()).thenAnswer(
      (_) async => appFailure(const NetworkFailure()),
    );

    final isAuthenticated = await useCase();

    expect(isAuthenticated, isTrue);
    verifyNever(() => logoutUseCase());
  });
}
