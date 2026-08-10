import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/features/inspections/domain/constants/inspection_geofence_constants.dart';
import 'package:inspetorsys/features/inspections/domain/geofence/inspection_geofence.dart';

void main() {
  test('returns warning when distance exceeds 200 meters', () {
    final message = buildGeofenceWarningMessage(
      workOrderLatitude: -7.1195,
      workOrderLongitude: -34.845,
      distanceMeters: 350,
    );

    expect(message, contains('350 m'));
    expect(message, contains('200 m'));
  });

  test('returns null when distance is within 200 meters', () {
    final message = buildGeofenceWarningMessage(
      workOrderLatitude: -7.1195,
      workOrderLongitude: -34.845,
      distanceMeters: InspectionGeofenceConstants.warningRadiusMeters,
    );

    expect(message, isNull);
  });

  test('returns null when work order has no coordinates', () {
    final message = buildGeofenceWarningMessage(
      workOrderLatitude: null,
      workOrderLongitude: null,
      distanceMeters: 500,
    );

    expect(message, isNull);
  });
}
