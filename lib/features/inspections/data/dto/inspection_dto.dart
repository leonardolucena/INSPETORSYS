import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';

part 'inspection_dto.freezed.dart';
part 'inspection_dto.g.dart';

@freezed
abstract class InspectionDto with _$InspectionDto {
  const factory InspectionDto({
    required String id,
    required String clientId,
    required String workOrderId,
    @JsonKey(name: 'observation') String? notes,
    String? condition,
    String? photoUrl,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'capturedAt') DateTime? capturedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? syncedAt,
  }) = _InspectionDto;

  factory InspectionDto.fromJson(Map<String, dynamic> json) =>
      _$InspectionDtoFromJson(json);
}

extension InspectionDtoMapper on InspectionDto {
  Inspection toDomain({
    required InspectionSyncStatus status,
    String? photoPath,
    String? syncErrorMessage,
  }) {
    final effectiveCreatedAt =
        capturedAt ?? createdAt ?? syncedAt ?? DateTime.now();
    final effectiveFormData = condition == null
        ? null
        : <String, dynamic>{
            'condition': condition,
          };

    return Inspection(
      clientId: clientId,
      serverId: id,
      workOrderId: workOrderId,
      status: status,
      notes: notes,
      photoPath: photoPath ?? photoUrl,
      latitude: latitude,
      longitude: longitude,
      capturedAt: capturedAt,
      formData: effectiveFormData,
      syncErrorMessage: syncErrorMessage,
      createdAt: effectiveCreatedAt,
      updatedAt: updatedAt ?? effectiveCreatedAt,
      syncedAt: syncedAt,
    );
  }
}
