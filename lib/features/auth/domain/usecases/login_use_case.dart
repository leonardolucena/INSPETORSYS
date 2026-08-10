import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/features/auth/domain/entities/login_result.dart';
import 'package:inspetorsys/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  AppAsyncResult<LoginResult> call({
    required String email,
    required String password,
  }) {
    return _authRepository.login(
      email: email.trim(),
      password: password,
    );
  }
}
