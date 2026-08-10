import 'package:geolocator/geolocator.dart';
import 'package:inspetorsys/core/location/geo_coordinates.dart';
import 'package:inspetorsys/core/location/location_exception.dart';
import 'package:inspetorsys/core/location/location_service.dart';
import 'package:inspetorsys/core/permissions/app_permission.dart';
import 'package:inspetorsys/core/permissions/permission_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LocationService)
class GeolocatorLocationService implements LocationService {
  GeolocatorLocationService(this._permissionService);

  final PermissionService _permissionService;

  @override
  Future<bool> isLocationServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<GeoCoordinates> getCurrentPosition() async {
    final granted = await _permissionService.ensureGranted(
      AppPermission.location,
    );
    if (!granted) {
      throw const AppLocationPermissionDeniedException();
    }

    if (!await isLocationServiceEnabled()) {
      throw const AppLocationServiceDisabledException();
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    return GeoCoordinates(
      latitude: position.latitude,
      longitude: position.longitude,
      accuracyMeters: position.accuracy,
      capturedAt: position.timestamp,
    );
  }

  @override
  Future<void> openLocationSettings() {
    return Geolocator.openLocationSettings();
  }
}
