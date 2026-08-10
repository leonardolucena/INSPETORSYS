import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspetorsys/features/auth/domain/usecases/logout_use_case.dart';
import 'package:inspetorsys/features/auth/domain/usecases/validate_session_use_case.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/auth_session_state.dart';
import 'package:inspetorsys/core/session/session_token_provider.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthSessionCubit extends Cubit<AuthSessionState> {
  AuthSessionCubit(
    this._sessionTokenProvider,
    this._validateSessionUseCase,
    this._logoutUseCase,
  ) : super(const AuthSessionState.unknown());

  final SessionTokenProvider _sessionTokenProvider;
  final ValidateSessionUseCase _validateSessionUseCase;
  final LogoutUseCase _logoutUseCase;

  Future<void> checkSession() async {
    try {
      final isAuthenticated = await _validateSessionUseCase();

      emit(
        isAuthenticated
            ? const AuthSessionState.authenticated()
            : const AuthSessionState.unauthenticated(),
      );
    } catch (_) {
      emit(const AuthSessionState.unauthenticated());
    }
  }

  Future<void> signOut() async {
    await _logoutUseCase();
    emit(const AuthSessionState.unauthenticated());
  }

  Future<void> signIn(String token) async {
    await _sessionTokenProvider.saveToken(token);
    emit(const AuthSessionState.authenticated());
  }
}
