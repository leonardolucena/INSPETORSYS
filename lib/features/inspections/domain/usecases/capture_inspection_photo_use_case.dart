import 'package:inspetorsys/core/image/inspection_photo_service.dart';
import 'package:inspetorsys/core/image/local_image_file.dart';
import 'package:injectable/injectable.dart';

@injectable
class CaptureInspectionPhotoUseCase {
  CaptureInspectionPhotoUseCase(this._inspectionPhotoService);

  final InspectionPhotoService _inspectionPhotoService;

  Future<LocalImageFile> call() {
    return _inspectionPhotoService.captureAndSave();
  }
}
