import 'dart:io';

import 'package:inspetorsys/core/image/local_image_file.dart';

abstract interface class ImageCompressor {
  Future<LocalImageFile> compress({
    required File source,
    required String targetPath,
  });
}
