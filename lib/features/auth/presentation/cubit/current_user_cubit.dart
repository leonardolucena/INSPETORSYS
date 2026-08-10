import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspetorsys/features/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/current_user_state.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CurrentUserCubit extends Cubit<CurrentUserState> {
  CurrentUserCubit(this._getCurrentUserUseCase)
      : super(const CurrentUserState());

  final GetCurrentUserUseCase _getCurrentUserUseCase;

  Future<void> load() async {
    if (state.status == CurrentUserStatus.loading) {
      return;
    }

    emit(state.copyWith(status: CurrentUserStatus.loading));

    final result = await _getCurrentUserUseCase();

    result.fold(
      (user) => emit(
        CurrentUserState(
          status: CurrentUserStatus.success,
          user: user,
        ),
      ),
      (_) => emit(
        const CurrentUserState(status: CurrentUserStatus.failure),
      ),
    );
  }
}
