import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inspetorsys/features/inspections/domain/constants/inspection_form_constants.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_form_field_type.dart';

part 'inspection_form_schema.freezed.dart';

@freezed
abstract class InspectionFormFieldSchema with _$InspectionFormFieldSchema {
  const factory InspectionFormFieldSchema({
    required String key,
    required InspectionFormFieldType type,
    required String label,
    @Default(false) bool required,
    int? minLength,
    @Default([]) List<String> options,
  }) = _InspectionFormFieldSchema;
}

@freezed
abstract class InspectionFormSchema with _$InspectionFormSchema {
  const InspectionFormSchema._();

  const factory InspectionFormSchema({
    required String workOrderId,
    required List<InspectionFormFieldSchema> fields,
  }) = _InspectionFormSchema;

  InspectionFormFieldSchema? fieldByKey(String key) {
    for (final field in fields) {
      if (field.key == key) {
        return field;
      }
    }

    return null;
  }

  int get observationMinLength =>
      fieldByKey('observation')?.minLength ??
      InspectionFormConstants.minNotesLength;
}
