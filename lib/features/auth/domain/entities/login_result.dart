import 'package:equatable/equatable.dart';
import 'package:inspetorsys/features/auth/domain/entities/auth_token.dart';
import 'package:inspetorsys/features/auth/domain/entities/user.dart';

class LoginResult extends Equatable {
  const LoginResult({
    required this.token,
    required this.user,
  });

  final AuthToken token;
  final User user;

  @override
  List<Object?> get props => [token, user];
}
