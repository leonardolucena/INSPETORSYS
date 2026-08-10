import 'package:inspetorsys/core/storage/token_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockTokenStorage extends Mock implements TokenStorage {}

void registerFallbackValues() {
  registerFallbackValue('');
}
