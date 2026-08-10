import 'package:inspetorsys/core/image/image_compressor.dart';
import 'package:inspetorsys/core/image/image_constants.dart';
import 'package:inspetorsys/core/image/image_exception.dart';
import 'package:inspetorsys/core/image/image_picker_service.dart';
import 'package:inspetorsys/core/image/local_image_file.dart';
import 'package:inspetorsys/core/storage/app_paths.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;

@lazySingleton
class InspectionPhotoService {
  InspectionPhotoService(
    this._appPaths,
    this._imagePickerService,
    this._imageCompressor,
  );

  final AppPaths _appPaths;
  final ImagePickerService _imagePickerService;
  final ImageCompressor _imageCompressor;

  Future<LocalImageFile> captureAndSave() async {
    final pickedFile = await _imagePickerService.pickFromCamera();
    if (pickedFile == null) {
      throw const ImageCaptureCancelledException();
    }

    try {
      final photosDirectory = await _appPaths.ensurePhotosDirectory();
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}${ImageConstants.compressedFileExtension}';
      final targetPath = p.join(photosDirectory.path, fileName);

      final compressedImage = await _imageCompressor.compress(
        source: pickedFile,
        targetPath: targetPath,
      );

      if (pickedFile.path != compressedImage.path) {
        await pickedFile.delete();
      }

      return compressedImage;
    } catch (error) {
      if (error is ImageException) {
        rethrow;
      }

      throw const ImageCompressionException();
    }
  }
}
