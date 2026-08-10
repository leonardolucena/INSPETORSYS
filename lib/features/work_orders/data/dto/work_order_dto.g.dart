// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkOrderDto _$WorkOrderDtoFromJson(Map<String, dynamic> json) =>
    _WorkOrderDto(
      id: json['id'] as String,
      code: json['code'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      notes: json['notes'] as String?,
      address: json['address'] as String,
      priority: $enumDecode(_$WorkOrderPriorityEnumMap, json['priority']),
      status: $enumDecode(_$WorkOrderStatusEnumMap, json['status']),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      scheduledAt: json['scheduledAt'] == null
          ? null
          : DateTime.parse(json['scheduledAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$WorkOrderDtoToJson(_WorkOrderDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'title': instance.title,
      'description': instance.description,
      'notes': instance.notes,
      'address': instance.address,
      'priority': _$WorkOrderPriorityEnumMap[instance.priority]!,
      'status': _$WorkOrderStatusEnumMap[instance.status]!,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'scheduledAt': instance.scheduledAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$WorkOrderPriorityEnumMap = {
  WorkOrderPriority.high: 'high',
  WorkOrderPriority.medium: 'medium',
  WorkOrderPriority.low: 'low',
};

const _$WorkOrderStatusEnumMap = {
  WorkOrderStatus.open: 'open',
  WorkOrderStatus.inProgress: 'in_progress',
  WorkOrderStatus.done: 'done',
};
