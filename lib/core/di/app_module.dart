import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inspetorsys/core/database/app_database.dart';
import 'package:inspetorsys/core/di/injection.dart';
import 'package:inspetorsys/core/network/dio_client.dart';
import 'package:inspetorsys/core/session/session_token_provider.dart';
import 'package:inspetorsys/core/storage/app_paths.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class AppModule {
  @preResolve
  @lazySingleton
  Future<AppPaths> appPaths() => AppPaths.create();

  @lazySingleton
  AppDatabase appDatabase(AppPaths appPaths) => AppDatabase(appPaths);

  @lazySingleton
  DioClient dioClient(SessionTokenProvider sessionTokenProvider) {
    return DioClient(
      tokenProvider: sessionTokenProvider.call,
      onUnauthorized: () => getIt<AuthSessionCubit>().signOut(),
    );
  }

  @lazySingleton
  Connectivity connectivity() => Connectivity();

  @lazySingleton
  InternetConnection internetConnection(Connectivity connectivity) {
    return InternetConnection.createInstance(
      triggerStream: connectivity.onConnectivityChanged,
    );
  }

  @lazySingleton
  ImagePicker imagePicker() => ImagePicker();

  @lazySingleton
  FlutterSecureStorage flutterSecureStorage() => const FlutterSecureStorage();

  @preResolve
  @lazySingleton
  Future<SharedPreferences> sharedPreferences() =>
      SharedPreferences.getInstance();
}
