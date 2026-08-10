import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/session/session_token_provider.dart';
import 'package:inspetorsys/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:inspetorsys/features/auth/domain/usecases/logout_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late MockTokenStorage tokenStorage;
  late SessionTokenProvider sessionTokenProvider;
  late MockAuthLocalDataSource authLocalDataSource;
  late LogoutUseCase useCase;

  setUp(() {
    tokenStorage = MockTokenStorage();
    sessionTokenProvider = SessionTokenProvider(tokenStorage);
    authLocalDataSource = MockAuthLocalDataSource();
    useCase = LogoutUseCase(sessionTokenProvider, authLocalDataSource);

    when(() => tokenStorage.deleteToken()).thenAnswer((_) async {});
    when(() => authLocalDataSource.clearSensitiveSessionData())
        .thenAnswer((_) async {});
  });

  test('clears token and sensitive local data', () async {
    await useCase();

    verify(() => tokenStorage.deleteToken()).called(1);
    verify(() => authLocalDataSource.clearSensitiveSessionData()).called(1);
  });
}
