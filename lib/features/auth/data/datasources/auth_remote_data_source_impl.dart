import 'package:dio/dio.dart';
import 'package:inspetorsys/core/constants/api_constants.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/dio_failure_mapper.dart';
import 'package:inspetorsys/core/network/dio_client.dart';
import 'package:inspetorsys/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:inspetorsys/features/auth/data/dto/login_response_dto.dart';
import 'package:inspetorsys/features/auth/data/dto/user_dto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<LoginResponseDto> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioClient.client.post<Map<String, dynamic>>(
        ApiConstants.loginPath,
        data: {
          'email': email,
          'password': password,
        },
      );

      return LoginResponseDto.fromJson(response.data!);
    } on DioException catch (exception) {
      throw mapDioExceptionToFailure(exception);
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const UnknownFailure();
    }
  }

  @override
  Future<UserDto> getCurrentUser() async {
    try {
      final response = await _dioClient.client.get<Map<String, dynamic>>(
        ApiConstants.currentUserPath,
      );

      return UserDto.fromJson(response.data!);
    } on DioException catch (exception) {
      throw mapDioExceptionToFailure(exception);
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const UnknownFailure();
    }
  }
}
