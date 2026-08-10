import 'package:dio/dio.dart';
import 'package:inspetorsys/core/constants/api_constants.dart';

typedef UnauthorizedCallback = Future<void> Function();

class ErrorInterceptor extends Interceptor {
  ErrorInterceptor({UnauthorizedCallback? onUnauthorized})
      : _onUnauthorized = onUnauthorized;

  final UnauthorizedCallback? _onUnauthorized;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;

    if (statusCode == 401 && !_isLoginRequest(err.requestOptions)) {
      await _onUnauthorized?.call();
    }

    handler.next(err);
  }

  bool _isLoginRequest(RequestOptions options) {
    final path = options.path;
    return path == ApiConstants.loginPath || path.endsWith(ApiConstants.loginPath);
  }
}
