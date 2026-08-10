import 'package:inspetorsys/core/errors/app_failure.dart';

enum FailureMessageContext {
  generic,
  login,
  workOrders,
  inspectionForm,
  inspectionHistory,
}

String mapFailureToUserMessage(
  AppFailure failure, {
  FailureMessageContext context = FailureMessageContext.generic,
}) {
  return switch (failure) {
    NetworkFailure() => failure.message,
    UnauthorizedFailure() => context == FailureMessageContext.login
        ? 'E-mail ou senha inválidos.'
        : failure.message,
    ValidationFailure() => failure.message,
    ConflictFailure() => failure.message,
    ServerFailure() => failure.message,
    CacheFailure() => failure.message,
    UnknownFailure() => _mapUnknownFailure(failure),
  };
}

String _mapUnknownFailure(UnknownFailure failure) {
  final normalized = failure.message.toLowerCase();

  if (_looksLikeNetworkIssue(normalized)) {
    return 'Sem conexão com a internet. Verifique sua rede e tente novamente.';
  }

  return failure.message;
}

bool _looksLikeNetworkIssue(String message) {
  const networkHints = [
    'socket',
    'network',
    'connection',
    'host lookup',
    'failed host lookup',
    'erro de rede',
    'internet',
    'offline',
  ];

  return networkHints.any(message.contains);
}
