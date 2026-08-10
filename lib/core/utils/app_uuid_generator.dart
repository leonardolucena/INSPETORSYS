import 'package:inspetorsys/core/utils/uuid_generator.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: UuidGenerator)
class AppUuidGenerator implements UuidGenerator {
  const AppUuidGenerator();

  static const _uuid = Uuid();

  @override
  String generateClientId() => _uuid.v4();
}
