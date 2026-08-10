// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspection_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InspectionDto _$InspectionDtoFromJson(Map<String, dynamic> json) =>
    _InspectionDto(
      id: json['id'] as String,
      clientId: json['clientId'] as String,
      workOrderId: json['workOrderId'] as String,
      notes: json['observation'] as String?,
      condition: json['condition'] as String?,
      photoUrl: json['photoUrl'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      capturedAt: json['capturedAt'] == null
          ? null
          : DateTime.parse(json['capturedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
    );

Map<String, dynamic> _$InspectionDtoToJson(_InspectionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'workOrderId': instance.workOrderId,
      'observation': instance.notes,
      'condition': instance.condition,
      'photoUrl': instance.photoUrl,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'capturedAt': instance.capturedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
    };
