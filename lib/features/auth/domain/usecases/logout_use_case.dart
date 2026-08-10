import 'package:inspetorsys/core/session/session_token_provider.dart';
import 'package:inspetorsys/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  LogoutUseCase(
    this._sessionTokenProvider,
    this._authLocalDataSource,
  );

  final SessionTokenProvider _sessionTokenProvider;
  final AuthLocalDataSource _authLocalDataSource;

  Future<void> call() async {
    await _sessionTokenProvider.clear();
    await _authLocalDataSource.clearSensitiveSessionData();
  }
}
