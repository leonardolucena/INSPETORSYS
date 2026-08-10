sealed class AppFailure implements Exception {
  const AppFailure(this.message);

  final String message;

  @override
  String toString() => message;
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure([
    super.message = 'Sem conexão com a internet. Tente novamente.',
  ]);
}

final class ServerFailure extends AppFailure {
  const ServerFailure([
    super.message = 'Erro no servidor. Tente novamente mais tarde.',
  ]);
}

final class UnauthorizedFailure extends AppFailure {
  const UnauthorizedFailure([
    super.message = 'Sessão expirada. Faça login novamente.',
  ]);
}

final class ValidationFailure extends AppFailure {
  const ValidationFailure({
    required String message,
    this.fieldErrors = const {},
  }) : super(message);

  final Map<String, String> fieldErrors;
}

final class ConflictFailure extends AppFailure {
  const ConflictFailure([
    super.message = 'Conflito ao sincronizar a inspeção.',
  ]);
}

final class CacheFailure extends AppFailure {
  const CacheFailure([
    super.message = 'Não foi possível acessar os dados locais.',
  ]);
}

final class UnknownFailure extends AppFailure {
  const UnknownFailure([
    super.message = 'Ocorreu um erro inesperado. Tente novamente.',
  ]);
}
