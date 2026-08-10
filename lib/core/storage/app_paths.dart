import 'dart:io';

import 'package:inspetorsys/core/constants/storage_constants.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AppPaths {
  AppPaths({required Directory documentsDirectory})
      : _documentsDirectory = documentsDirectory;

  final Directory _documentsDirectory;

  static Future<AppPaths> create() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    return AppPaths(documentsDirectory: documentsDirectory);
  }

  String get databasePath =>
      p.join(_documentsDirectory.path, StorageConstants.databaseFileName);

  Directory get photosDirectory => Directory(
        p.join(_documentsDirectory.path, StorageConstants.photosDirectoryName),
      );

  Future<Directory> ensurePhotosDirectory() async {
    final directory = photosDirectory;
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return directory;
  }
}
