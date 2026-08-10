import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/session/session_token_provider.dart';
import 'package:inspetorsys/features/auth/domain/repositories/auth_repository.dart';
import 'package:inspetorsys/features/auth/domain/usecases/logout_use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class ValidateSessionUseCase {
  ValidateSessionUseCase(
    this._authRepository,
    this._sessionTokenProvider,
    this._logoutUseCase,
  );

  final AuthRepository _authRepository;
  final SessionTokenProvider _sessionTokenProvider;
  final LogoutUseCase _logoutUseCase;

  Future<bool> call() async {
    await _sessionTokenProvider.load();

    if (!_sessionTokenProvider.hasToken) {
      return false;
    }

    final result = await _authRepository.getCurrentUser();
    var shouldLogout = false;
    var isAuthenticated = true;

    result.fold(
      (_) => isAuthenticated = true,
      (failure) {
        if (failure is UnauthorizedFailure) {
          shouldLogout = true;
          isAuthenticated = false;
        }
      },
    );

    if (shouldLogout) {
      await _logoutUseCase();
    }

    return isAuthenticated;
  }
}
