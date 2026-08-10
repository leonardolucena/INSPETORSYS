import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/constants/api_constants.dart';
import 'package:inspetorsys/core/network/interceptors/error_interceptor.dart';

void main() {
  group('ErrorInterceptor', () {
    test('calls onUnauthorized for 401 outside login', () async {
      var unauthorizedCalls = 0;
      final interceptor = ErrorInterceptor(
        onUnauthorized: () async {
          unauthorizedCalls++;
        },
      );

      final handler = _RecordingErrorInterceptorHandler();
      await interceptor.onError(
        DioException(
          requestOptions: RequestOptions(path: '/work-orders'),
          response: Response(
            requestOptions: RequestOptions(path: '/work-orders'),
            statusCode: 401,
          ),
          type: DioExceptionType.badResponse,
        ),
        handler,
      );

      expect(unauthorizedCalls, 1);
      expect(handler.forwarded, isTrue);
    });

    test('does not call onUnauthorized for login 401', () async {
      var unauthorizedCalls = 0;
      final interceptor = ErrorInterceptor(
        onUnauthorized: () async {
          unauthorizedCalls++;
        },
      );

      final handler = _RecordingErrorInterceptorHandler();
      await interceptor.onError(
        DioException(
          requestOptions: RequestOptions(path: ApiConstants.loginPath),
          response: Response(
            requestOptions: RequestOptions(path: ApiConstants.loginPath),
            statusCode: 401,
          ),
          type: DioExceptionType.badResponse,
        ),
        handler,
      );

      expect(unauthorizedCalls, 0);
      expect(handler.forwarded, isTrue);
    });
  });
}

class _RecordingErrorInterceptorHandler extends ErrorInterceptorHandler {
  bool forwarded = false;

  @override
  void next(DioException err) {
    forwarded = true;
  }
}
