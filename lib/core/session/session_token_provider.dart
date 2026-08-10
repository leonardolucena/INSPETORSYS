import 'package:inspetorsys/core/storage/token_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SessionTokenProvider {
  SessionTokenProvider(this._tokenStorage);

  final TokenStorage _tokenStorage;

  String? _cachedToken;

  String? call() => _cachedToken;

  bool get hasToken => _cachedToken != null && _cachedToken!.isNotEmpty;

  Future<void> load() async {
    _cachedToken = await _tokenStorage.readToken();
  }

  Future<void> saveToken(String token) async {
    await _tokenStorage.writeToken(token);
    _cachedToken = token;
  }

  Future<void> clear() async {
    await _tokenStorage.deleteToken();
    _cachedToken = null;
  }
}
