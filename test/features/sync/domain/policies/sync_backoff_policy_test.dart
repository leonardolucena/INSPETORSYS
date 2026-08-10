import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/features/sync/domain/policies/sync_backoff_policy.dart';

void main() {
  test('calculates exponential delay from base delay', () {
    expect(
      SyncBackoffPolicy.delayForAttempt(1),
      const Duration(seconds: 60),
    );
    expect(
      SyncBackoffPolicy.delayForAttempt(2),
      const Duration(seconds: 120),
    );
    expect(
      SyncBackoffPolicy.delayForAttempt(3),
      const Duration(seconds: 240),
    );
  });

  test('schedules next retry based on attempt count', () {
    final from = DateTime.parse('2026-07-26T12:00:00.000Z');

    expect(
      SyncBackoffPolicy.nextRetryAtForAttempt(1, from),
      DateTime.parse('2026-07-26T12:01:00.000Z'),
    );
  });

  test('detects when retry limit is exceeded', () {
    expect(SyncBackoffPolicy.hasExceededMaxRetries(4), isFalse);
    expect(SyncBackoffPolicy.hasExceededMaxRetries(5), isTrue);
  });
}
