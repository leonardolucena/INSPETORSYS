import 'package:inspetorsys/core/location/geo_coordinates.dart';

abstract interface class LocationService {
  Future<bool> isLocationServiceEnabled();

  Future<GeoCoordinates> getCurrentPosition();

  Future<void> openLocationSettings();
}
