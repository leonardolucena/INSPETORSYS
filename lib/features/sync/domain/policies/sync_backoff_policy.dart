abstract final class SyncBackoffPolicy {
  static const int maxRetryCount = 5;
  static const Duration baseDelay = Duration(seconds: 30);

  static Duration delayForAttempt(int retryCount) {
    final exponent = retryCount.clamp(0, 10);
    return baseDelay * (1 << exponent);
  }

  static DateTime nextRetryAtForAttempt(int retryCount, [DateTime? from]) {
    return (from ?? DateTime.now()).add(delayForAttempt(retryCount));
  }

  static bool hasExceededMaxRetries(int retryCount) {
    return retryCount >= maxRetryCount;
  }
}
