import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({String? Function()? tokenProvider})
      : _tokenProvider = tokenProvider;

  final String? Function()? _tokenProvider;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _tokenProvider?.call();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
