// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspection_form_schema_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InspectionFormFieldSchemaDto _$InspectionFormFieldSchemaDtoFromJson(
  Map<String, dynamic> json,
) => _InspectionFormFieldSchemaDto(
  key: json['key'] as String,
  type: json['type'] as String,
  label: json['label'] as String,
  isRequired: json['required'] as bool? ?? false,
  minLength: (json['minLength'] as num?)?.toInt(),
  options: (json['options'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$InspectionFormFieldSchemaDtoToJson(
  _InspectionFormFieldSchemaDto instance,
) => <String, dynamic>{
  'key': instance.key,
  'type': instance.type,
  'label': instance.label,
  'required': instance.isRequired,
  'minLength': instance.minLength,
  'options': instance.options,
};

_InspectionFormSchemaDto _$InspectionFormSchemaDtoFromJson(
  Map<String, dynamic> json,
) => _InspectionFormSchemaDto(
  workOrderId: json['workOrderId'] as String,
  fields: (json['fields'] as List<dynamic>)
      .map(
        (e) => InspectionFormFieldSchemaDto.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$InspectionFormSchemaDtoToJson(
  _InspectionFormSchemaDto instance,
) => <String, dynamic>{
  'workOrderId': instance.workOrderId,
  'fields': instance.fields,
};
