import 'package:inspetorsys/features/inspections/domain/constants/inspection_geofence_constants.dart';

String? buildGeofenceWarningMessage({
  required double? workOrderLatitude,
  required double? workOrderLongitude,
  required double distanceMeters,
}) {
  if (workOrderLatitude == null || workOrderLongitude == null) {
    return null;
  }

  if (distanceMeters <= InspectionGeofenceConstants.warningRadiusMeters) {
    return null;
  }

  return 'Você está a ${distanceMeters.round()} m do ponto da OS '
      '(limite: ${InspectionGeofenceConstants.warningRadiusMeters.round()} m).';
}
