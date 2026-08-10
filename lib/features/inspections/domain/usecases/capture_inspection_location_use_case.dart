import 'package:inspetorsys/core/location/geo_coordinates.dart';
import 'package:inspetorsys/core/location/location_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class CaptureInspectionLocationUseCase {
  CaptureInspectionLocationUseCase(this._locationService);

  final LocationService _locationService;

  Future<GeoCoordinates> call() {
    return _locationService.getCurrentPosition();
  }
}
