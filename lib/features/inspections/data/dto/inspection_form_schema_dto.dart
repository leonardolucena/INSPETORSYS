import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_schema.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_form_field_type.dart';

part 'inspection_form_schema_dto.freezed.dart';
part 'inspection_form_schema_dto.g.dart';

@freezed
abstract class InspectionFormFieldSchemaDto with _$InspectionFormFieldSchemaDto {
  const factory InspectionFormFieldSchemaDto({
    required String key,
    required String type,
    required String label,
    @JsonKey(name: 'required') @Default(false) bool isRequired,
    int? minLength,
    List<String>? options,
  }) = _InspectionFormFieldSchemaDto;

  factory InspectionFormFieldSchemaDto.fromJson(Map<String, dynamic> json) =>
      _$InspectionFormFieldSchemaDtoFromJson(json);
}

@freezed
abstract class InspectionFormSchemaDto with _$InspectionFormSchemaDto {
  const factory InspectionFormSchemaDto({
    required String workOrderId,
    required List<InspectionFormFieldSchemaDto> fields,
  }) = _InspectionFormSchemaDto;

  factory InspectionFormSchemaDto.fromJson(Map<String, dynamic> json) =>
      _$InspectionFormSchemaDtoFromJson(json);
}

extension InspectionFormSchemaDtoMapper on InspectionFormSchemaDto {
  InspectionFormSchema toDomain() {
    return InspectionFormSchema(
      workOrderId: workOrderId,
      fields: fields.map((field) => field.toDomain()).toList(),
    );
  }
}

extension InspectionFormFieldSchemaDtoMapper on InspectionFormFieldSchemaDto {
  InspectionFormFieldSchema toDomain() {
    return InspectionFormFieldSchema(
      key: key,
      type: InspectionFormFieldTypeX.fromApiValue(type),
      label: label,
      required: isRequired,
      minLength: minLength,
      options: options ?? const [],
    );
  }
}
