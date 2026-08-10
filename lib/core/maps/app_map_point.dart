import 'package:latlong2/latlong.dart';

enum AppMapPointType {
  workOrder,
  inspection,
}

class AppMapPoint {
  const AppMapPoint({
    required this.latitude,
    required this.longitude,
    required this.label,
    this.type = AppMapPointType.workOrder,
  });

  final double latitude;
  final double longitude;
  final String label;
  final AppMapPointType type;

  LatLng get latLng => LatLng(latitude, longitude);
}
