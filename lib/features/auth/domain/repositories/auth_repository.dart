import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/features/auth/domain/entities/login_result.dart';
import 'package:inspetorsys/features/auth/domain/entities/user.dart';

abstract interface class AuthRepository {
  AppAsyncResult<LoginResult> login({
    required String email,
    required String password,
  });

  AppAsyncResult<User> getCurrentUser();
}
