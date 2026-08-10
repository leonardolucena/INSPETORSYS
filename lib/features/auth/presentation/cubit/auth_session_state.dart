import 'package:equatable/equatable.dart';

enum AuthSessionStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthSessionState extends Equatable {
  const AuthSessionState._(this.status);

  const AuthSessionState.unknown() : this._(AuthSessionStatus.unknown);

  const AuthSessionState.authenticated()
      : this._(AuthSessionStatus.authenticated);

  const AuthSessionState.unauthenticated()
      : this._(AuthSessionStatus.unauthenticated);

  final AuthSessionStatus status;

  bool get isAuthenticated => status == AuthSessionStatus.authenticated;

  @override
  List<Object?> get props => [status];
}
