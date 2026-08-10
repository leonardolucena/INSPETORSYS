import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:result_dart/result_dart.dart';

typedef AppResult<T extends Object> = ResultDart<T, AppFailure>;

typedef AppAsyncResult<T extends Object> = Future<AppResult<T>>;

AppResult<T> appSuccess<T extends Object>(T value) => Success(value);

AppResult<T> appFailure<T extends Object>(AppFailure failure) => Failure(failure);

AppAsyncResult<T> runAppResult<T extends Object>(
  Future<T> Function() action,
) async {
  try {
    return Success(await action());
  } on AppFailure catch (failure) {
    return Failure(failure);
  } catch (error) {
    return Failure(UnknownFailure(error.toString()));
  }
}

AppResult<T> runAppResultSync<T extends Object>(T Function() action) {
  try {
    return Success(action());
  } on AppFailure catch (failure) {
    return Failure(failure);
  } catch (error) {
    return Failure(UnknownFailure(error.toString()));
  }
}

extension AppResultX<T extends Object> on AppResult<T> {
  T getOrThrow() {
    return fold(
      (success) => success,
      (failure) => throw failure,
    );
  }

  T? getOrNull() {
    return fold(
      (success) => success,
      (_) => null,
    );
  }
}
