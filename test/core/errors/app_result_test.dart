import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/app_result.dart';

void main() {
  group('runAppResult', () {
    test('returns success when action completes', () async {
      final result = await runAppResult(() async => 'ok');

      expect(result.isSuccess(), isTrue);
      expect(result.getOrNull(), 'ok');
    });

    test('returns failure when AppFailure is thrown', () async {
      const failure = NetworkFailure('offline');

      final result = await runAppResult<String>(() async {
        throw failure;
      });

      expect(result.isError(), isTrue);
      result.fold(
        (_) => fail('expected failure'),
        (error) => expect(error, failure),
      );
    });

    test('wraps unexpected errors as UnknownFailure', () async {
      final result = await runAppResult<String>(() async {
        throw Exception('boom');
      });

      expect(result.isError(), isTrue);
      result.fold(
        (_) => fail('expected failure'),
        (error) => expect(error, isA<UnknownFailure>()),
      );
    });
  });

  group('runAppResultSync', () {
    test('returns success for synchronous values', () {
      final result = runAppResultSync(() => 42);

      expect(result.getOrNull(), 42);
    });
  });
}
