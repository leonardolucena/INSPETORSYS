import 'dart:io';

abstract interface class ImagePickerService {
  Future<File?> pickFromCamera();
}
