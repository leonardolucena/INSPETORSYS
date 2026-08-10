import 'package:inspetorsys/features/auth/data/dto/login_response_dto.dart';
import 'package:inspetorsys/features/auth/data/dto/user_dto.dart';

abstract interface class AuthRemoteDataSource {
  Future<LoginResponseDto> login({
    required String email,
    required String password,
  });

  Future<UserDto> getCurrentUser();
}
