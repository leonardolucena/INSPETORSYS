import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:inspetorsys/core/image/image_constants.dart';
import 'package:inspetorsys/core/image/image_exception.dart';
import 'package:inspetorsys/core/image/image_picker_service.dart';
import 'package:inspetorsys/core/permissions/app_permission.dart';
import 'package:inspetorsys/core/permissions/permission_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ImagePickerService)
class AppImagePickerService implements ImagePickerService {
  AppImagePickerService(
    this._permissionService,
    this._imagePicker,
  );

  final PermissionService _permissionService;
  final ImagePicker _imagePicker;

  @override
  Future<File?> pickFromCamera() async {
    final granted = await _permissionService.ensureGranted(
      AppPermission.camera,
    );
    if (!granted) {
      throw const ImagePermissionDeniedException();
    }

    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      maxWidth: ImageConstants.maxDimension.toDouble(),
      maxHeight: ImageConstants.maxDimension.toDouble(),
      imageQuality: ImageConstants.qualitySteps.first,
    );

    if (pickedFile == null) {
      return null;
    }

    return File(pickedFile.path);
  }
}
