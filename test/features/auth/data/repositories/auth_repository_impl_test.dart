import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:inspetorsys/features/auth/data/dto/login_response_dto.dart';
import 'package:inspetorsys/features/auth/data/dto/user_dto.dart';
import 'package:inspetorsys/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late MockAuthRemoteDataSource remoteDataSource;
  late AuthRepositoryImpl repository;

  const loginResponse = LoginResponseDto(
    accessToken: 'token-123',
    user: UserDto(
      id: 'user_1',
      name: 'Inspetor',
      email: 'inspetor@example.com',
    ),
  );

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(remoteDataSource);
  });

  group('login', () {
    test('returns login result when remote succeeds', () async {
      when(
        () => remoteDataSource.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => loginResponse);

      final result = await repository.login(
        email: 'inspetor@example.com',
        password: '123456',
      );

      expect(result.isSuccess(), isTrue);
      expect(result.getOrNull()?.token.value, 'token-123');
      expect(result.getOrNull()?.user.email, 'inspetor@example.com');
    });

    test('returns network failure when remote throws NetworkFailure', () async {
      when(
        () => remoteDataSource.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(
        const NetworkFailure(
          'Sem conexão com a internet. Verifique sua rede e tente novamente.',
        ),
      );

      final result = await repository.login(
        email: 'inspetor@example.com',
        password: '123456',
      );

      expect(result.isError(), isTrue);
      expect(result.exceptionOrNull(), isA<NetworkFailure>());
    });

    test('returns validation failure when credentials are invalid', () async {
      when(
        () => remoteDataSource.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(
        const ValidationFailure(message: 'Dados inválidos.'),
      );

      final result = await repository.login(
        email: 'invalido',
        password: '123',
      );

      expect(result.isError(), isTrue);
      expect(result.exceptionOrNull(), isA<ValidationFailure>());
    });
  });

  group('getCurrentUser', () {
    test('returns user when remote succeeds', () async {
      when(() => remoteDataSource.getCurrentUser()).thenAnswer(
        (_) async => loginResponse.user,
      );

      final result = await repository.getCurrentUser();

      expect(result.isSuccess(), isTrue);
      expect(result.getOrNull()?.email, 'inspetor@example.com');
    });

    test('returns unauthorized failure when session is invalid', () async {
      when(() => remoteDataSource.getCurrentUser())
          .thenThrow(const UnauthorizedFailure());

      final result = await repository.getCurrentUser();

      expect(result.isError(), isTrue);
      expect(result.exceptionOrNull(), isA<UnauthorizedFailure>());
    });
  });
}
