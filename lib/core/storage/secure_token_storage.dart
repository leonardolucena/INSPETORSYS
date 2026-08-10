import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inspetorsys/core/constants/storage_constants.dart';
import 'package:inspetorsys/core/storage/token_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TokenStorage)
class SecureTokenStorage implements TokenStorage {
  SecureTokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<String?> readToken() {
    return _storage.read(key: StorageConstants.authTokenKey);
  }

  @override
  Future<void> writeToken(String token) {
    return _storage.write(
      key: StorageConstants.authTokenKey,
      value: token,
    );
  }

  @override
  Future<void> deleteToken() {
    return _storage.delete(key: StorageConstants.authTokenKey);
  }
}
