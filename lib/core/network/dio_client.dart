import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:inspetorsys/core/constants/api_constants.dart';
import 'package:inspetorsys/core/network/interceptors/auth_interceptor.dart';
import 'package:inspetorsys/core/network/interceptors/error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  DioClient({
    String? baseUrl,
    String? Function()? tokenProvider,
    UnauthorizedCallback? onUnauthorized,
    List<Interceptor>? extraInterceptors,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll(
      _buildInterceptors(
        tokenProvider: tokenProvider,
        onUnauthorized: onUnauthorized,
        extraInterceptors: extraInterceptors,
      ),
    );
  }

  late final Dio _dio;

  Dio get client => _dio;

  List<Interceptor> _buildInterceptors({
    String? Function()? tokenProvider,
    UnauthorizedCallback? onUnauthorized,
    List<Interceptor>? extraInterceptors,
  }) {
    final interceptors = <Interceptor>[
      AuthInterceptor(tokenProvider: tokenProvider),
      ErrorInterceptor(onUnauthorized: onUnauthorized),
      if (extraInterceptors != null) ...extraInterceptors,
      if (kDebugMode)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          compact: true,
        ),
    ];

    return interceptors;
  }
}
