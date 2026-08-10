import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_schema.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';

part 'inspection.freezed.dart';

@freezed
abstract class Inspection with _$Inspection {
  const factory Inspection({
    required String clientId,
    String? serverId,
    required String workOrderId,
    String? workOrderCode,
    double? workOrderLatitude,
    double? workOrderLongitude,
    required InspectionSyncStatus status,
    String? notes,
    String? photoPath,
    double? latitude,
    double? longitude,
    DateTime? capturedAt,
    Map<String, dynamic>? formData,
    InspectionFormSchema? formSchema,
    String? syncErrorMessage,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
  }) = _Inspection;
}
