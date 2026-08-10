import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/features/auth/domain/entities/user.dart';
import 'package:inspetorsys/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCurrentUserUseCase {
  GetCurrentUserUseCase(this._authRepository);

  final AuthRepository _authRepository;

  AppAsyncResult<User> call() => _authRepository.getCurrentUser();
}
