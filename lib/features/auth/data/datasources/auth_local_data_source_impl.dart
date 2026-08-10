import 'package:inspetorsys/core/database/app_database.dart';
import 'package:inspetorsys/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._database);

  final AppDatabase _database;

  @override
  Future<void> clearSensitiveSessionData() {
    return _database.clearSensitiveSessionData();
  }
}
