import 'package:dio/dio.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';

AppFailure mapDioExceptionToFailure(DioException exception) {
  switch (exception.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.transformTimeout:
      return const NetworkFailure(
        'Tempo de conexão esgotado. Verifique sua internet.',
      );
    case DioExceptionType.sendTimeout:
      return const NetworkFailure(
        'Não foi possível enviar os dados. Verifique sua conexão.',
      );
    case DioExceptionType.receiveTimeout:
      return const NetworkFailure(
        'O servidor demorou para responder. Tente novamente.',
      );
    case DioExceptionType.connectionError:
      return const NetworkFailure(
        'Sem conexão com a internet. Verifique sua rede e tente novamente.',
      );
    case DioExceptionType.badResponse:
      return _mapBadResponse(exception);
    case DioExceptionType.cancel:
      return const UnknownFailure('Requisição cancelada.');
    case DioExceptionType.badCertificate:
      return const NetworkFailure(
        'Conexão segura indisponível. Verifique sua rede e tente novamente.',
      );
    case DioExceptionType.unknown:
      if (_isConnectionIssue(exception)) {
        return const NetworkFailure(
          'Sem conexão com a internet. Verifique sua rede e tente novamente.',
        );
      }
      return UnknownFailure(
        exception.message ?? 'Ocorreu um erro inesperado. Tente novamente.',
      );
  }
}

AppFailure _mapBadResponse(DioException exception) {
  final statusCode = exception.response?.statusCode;
  final data = exception.response?.data;

  if (statusCode == 401) {
    return const UnauthorizedFailure();
  }

  if (statusCode == 409 && data is Map<String, dynamic>) {
    final message = data['message'] as String? ?? 'Conflito ao processar a requisição.';
    return ConflictFailure(message);
  }

  if (statusCode == 400 && data is Map<String, dynamic>) {
    final message = data['message'] as String? ?? 'Dados inválidos.';
    final rawErrors = data['errors'];
    final fieldErrors = <String, String>{};

    if (rawErrors is Map) {
      rawErrors.forEach((key, value) {
        final fieldName = _normalizeFieldName(key);
        final fieldMessage = _extractFieldErrorMessage(value);
        if (fieldName != null && fieldMessage != null) {
          fieldErrors[fieldName] = fieldMessage;
        }
      });
    }

    return ValidationFailure(
      message: message,
      fieldErrors: fieldErrors,
    );
  }

  if (statusCode != null && statusCode >= 500) {
    return const ServerFailure();
  }

  if (data is Map<String, dynamic>) {
    final message = data['message'] as String?;
    if (message != null && message.isNotEmpty) {
      return ServerFailure(message);
    }
  }

  return const ServerFailure();
}

String? _normalizeFieldName(Object? key) {
  if (key is! String || key.isEmpty) {
    return null;
  }

  return switch (key) {
    'email' || 'e-mail' || 'userEmail' => 'email',
    'password' || 'senha' => 'password',
    _ => key,
  };
}

String? _extractFieldErrorMessage(Object? value) {
  if (value is String && value.isNotEmpty) {
    return value;
  }

  if (value is List) {
    for (final item in value) {
      if (item is String && item.isNotEmpty) {
        return item;
      }
    }
  }

  return null;
}

bool _isConnectionIssue(DioException exception) {
  final message = exception.message?.toLowerCase() ?? '';
  const hints = [
    'socket',
    'network',
    'connection',
    'host lookup',
    'failed host lookup',
    'network is unreachable',
    'no address associated with hostname',
  ];

  return hints.any(message.contains);
}
