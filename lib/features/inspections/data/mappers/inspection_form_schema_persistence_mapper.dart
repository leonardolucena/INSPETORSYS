import 'dart:convert';

import 'package:inspetorsys/features/inspections/data/dto/inspection_form_schema_dto.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_schema.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_form_field_type.dart';

extension InspectionFormSchemaPersistenceMapper on InspectionFormSchema {
  String toJsonString() {
    return jsonEncode(toDto().toJson());
  }
}

extension InspectionFormSchemaDtoPersistenceMapper on InspectionFormSchemaDto {
  InspectionFormSchema toDomainEntity() => toDomain();
}

InspectionFormSchema? decodeInspectionFormSchema(String? formSchemaJson) {
  if (formSchemaJson == null || formSchemaJson.isEmpty) {
    return null;
  }

  final decoded = jsonDecode(formSchemaJson);
  if (decoded is! Map<String, dynamic>) {
    return null;
  }

  return InspectionFormSchemaDto.fromJson(decoded).toDomain();
}

extension _InspectionFormSchemaToDto on InspectionFormSchema {
  InspectionFormSchemaDto toDto() {
    return InspectionFormSchemaDto(
      workOrderId: workOrderId,
      fields: fields
          .map(
            (field) => InspectionFormFieldSchemaDto(
              key: field.key,
              type: field.type.apiValue,
              label: field.label,
              isRequired: field.required,
              minLength: field.minLength,
              options: field.options.isEmpty ? null : field.options,
            ),
          )
          .toList(),
    );
  }
}
