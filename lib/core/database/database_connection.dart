import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:inspetorsys/core/storage/app_paths.dart';

QueryExecutor openDatabaseConnection(AppPaths appPaths) {
  return LazyDatabase(() async {
    final file = File(appPaths.databasePath);
    return NativeDatabase.createInBackground(file);
  });
}
