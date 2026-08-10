import 'package:equatable/equatable.dart';
import 'package:inspetorsys/features/auth/domain/entities/user.dart';

enum CurrentUserStatus {
  initial,
  loading,
  success,
  failure,
}

class CurrentUserState extends Equatable {
  const CurrentUserState({
    this.status = CurrentUserStatus.initial,
    this.user,
  });

  final CurrentUserStatus status;
  final User? user;

  CurrentUserState copyWith({
    CurrentUserStatus? status,
    User? user,
  }) {
    return CurrentUserState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, user];
}
