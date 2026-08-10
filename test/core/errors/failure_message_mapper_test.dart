import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/failure_message_mapper.dart';

void main() {
  group('mapFailureToUserMessage', () {
    test('maps login unauthorized to friendly message', () {
      const failure = UnauthorizedFailure();

      final message = mapFailureToUserMessage(
        failure,
        context: FailureMessageContext.login,
      );

      expect(message, 'E-mail ou senha inválidos.');
    });

    test('keeps default unauthorized message outside login', () {
      const failure = UnauthorizedFailure();

      final message = mapFailureToUserMessage(failure);

      expect(message, failure.message);
    });

    test('returns network failure message as-is', () {
      const failure = NetworkFailure(
        'Sem conexão com a internet. Verifique sua rede e tente novamente.',
      );

      final message = mapFailureToUserMessage(failure);

      expect(message, failure.message);
    });

    test('maps unknown socket errors to readable network message', () {
      const failure = UnknownFailure('SocketException: Failed host lookup');

      final message = mapFailureToUserMessage(failure);

      expect(
        message,
        'Sem conexão com a internet. Verifique sua rede e tente novamente.',
      );
    });

    test('keeps unrelated unknown failure message', () {
      const failure = UnknownFailure('Requisição cancelada.');

      final message = mapFailureToUserMessage(failure);

      expect(message, 'Requisição cancelada.');
    });
  });
}
