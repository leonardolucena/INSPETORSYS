import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/dio_failure_mapper.dart';

void main() {
  group('mapDioExceptionToFailure', () {
    test('maps timeout to NetworkFailure', () {
      final failure = mapDioExceptionToFailure(
        DioException(
          requestOptions: RequestOptions(path: '/work-orders'),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      expect(failure, isA<NetworkFailure>());
      expect(failure.message, contains('Tempo de conexão'));
    });

    test('maps connection error to readable NetworkFailure', () {
      final failure = mapDioExceptionToFailure(
        DioException(
          requestOptions: RequestOptions(path: '/work-orders'),
          type: DioExceptionType.connectionError,
        ),
      );

      expect(failure, isA<NetworkFailure>());
      expect(failure.message, contains('Sem conexão com a internet'));
    });

    test('maps send timeout to readable NetworkFailure', () {
      final failure = mapDioExceptionToFailure(
        DioException(
          requestOptions: RequestOptions(path: '/inspections'),
          type: DioExceptionType.sendTimeout,
        ),
      );

      expect(failure, isA<NetworkFailure>());
      expect(failure.message, contains('enviar os dados'));
    });

    test('maps unknown socket errors to NetworkFailure', () {
      final failure = mapDioExceptionToFailure(
        DioException(
          requestOptions: RequestOptions(path: '/work-orders'),
          type: DioExceptionType.unknown,
          message: 'SocketException: Failed host lookup',
        ),
      );

      expect(failure, isA<NetworkFailure>());
      expect(failure.message, contains('Sem conexão com a internet'));
    });

    test('maps 401 to UnauthorizedFailure', () {
      final failure = mapDioExceptionToFailure(
        DioException(
          requestOptions: RequestOptions(path: '/work-orders'),
          response: Response(
            requestOptions: RequestOptions(path: '/work-orders'),
            statusCode: 401,
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      expect(failure, isA<UnauthorizedFailure>());
    });

    test('maps 400 with field errors to ValidationFailure', () {
      final failure = mapDioExceptionToFailure(
        DioException(
          requestOptions: RequestOptions(path: '/auth/login'),
          response: Response(
            requestOptions: RequestOptions(path: '/auth/login'),
            statusCode: 400,
            data: {
              'message': 'Dados inválidos.',
              'errors': {
                'email': ['Informe um e-mail válido.'],
                'password': 'A senha deve ter no mínimo 6 caracteres.',
              },
            },
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      expect(failure, isA<ValidationFailure>());
      final validationFailure = failure as ValidationFailure;
      expect(validationFailure.message, 'Dados inválidos.');
      expect(validationFailure.fieldErrors['email'], 'Informe um e-mail válido.');
      expect(
        validationFailure.fieldErrors['password'],
        'A senha deve ter no mínimo 6 caracteres.',
      );
    });
  });
}
