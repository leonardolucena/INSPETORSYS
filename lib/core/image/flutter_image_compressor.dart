import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:inspetorsys/core/image/image_compressor.dart';
import 'package:inspetorsys/core/image/image_constants.dart';
import 'package:inspetorsys/core/image/image_exception.dart';
import 'package:inspetorsys/core/image/local_image_file.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ImageCompressor)
class FlutterImageCompressor implements ImageCompressor {
  @override
  Future<LocalImageFile> compress({
    required File source,
    required String targetPath,
  }) async {
    XFile? compressedFile;

    for (final quality in ImageConstants.qualitySteps) {
      compressedFile = await FlutterImageCompress.compressAndGetFile(
        source.path,
        targetPath,
        minWidth: ImageConstants.maxDimension,
        minHeight: ImageConstants.maxDimension,
        quality: quality,
      );

      if (compressedFile == null) {
        continue;
      }

      final outputFile = File(compressedFile.path);
      final sizeBytes = await outputFile.length();
      if (sizeBytes <= ImageConstants.maxFileSizeBytes) {
        return LocalImageFile(
          path: outputFile.path,
          sizeBytes: sizeBytes,
        );
      }
    }

    if (compressedFile == null) {
      throw const ImageCompressionException();
    }

    final outputFile = File(compressedFile.path);
    return LocalImageFile(
      path: outputFile.path,
      sizeBytes: await outputFile.length(),
    );
  }
}
