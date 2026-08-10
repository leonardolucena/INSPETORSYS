import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:inspetorsys/features/auth/data/dto/login_response_dto.dart';
import 'package:inspetorsys/features/auth/data/dto/user_dto.dart';
import 'package:inspetorsys/features/auth/domain/entities/login_result.dart';
import 'package:inspetorsys/features/auth/domain/entities/user.dart';
import 'package:inspetorsys/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  AppAsyncResult<LoginResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.login(
        email: email,
        password: password,
      );

      return appSuccess(
        LoginResult(
          token: response.toAuthToken(),
          user: response.user.toDomain(),
        ),
      );
    } on AppFailure catch (failure) {
      return appFailure(failure);
    } catch (_) {
      return appFailure(const UnknownFailure());
    }
  }

  @override
  AppAsyncResult<User> getCurrentUser() async {
    try {
      final user = await _remoteDataSource.getCurrentUser();
      return appSuccess(user.toDomain());
    } on AppFailure catch (failure) {
      return appFailure(failure);
    } catch (_) {
      return appFailure(const UnknownFailure());
    }
  }
}
