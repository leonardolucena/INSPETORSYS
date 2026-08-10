import 'package:equatable/equatable.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_schema.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_condition.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_form_field_type.dart';
import 'package:inspetorsys/features/inspections/domain/validators/inspection_notes_validator.dart';

class InspectionCompletionValidation extends Equatable {
  const InspectionCompletionValidation({
    this.notesError,
    this.photoError,
    this.locationError,
    this.conditionError,
  });

  final String? notesError;
  final String? photoError;
  final String? locationError;
  final String? conditionError;

  bool get isValid =>
      notesError == null &&
      photoError == null &&
      locationError == null &&
      conditionError == null;

  @override
  List<Object?> get props => [
        notesError,
        photoError,
        locationError,
        conditionError,
      ];
}

InspectionCompletionValidation validateInspectionForCompletion({
  required InspectionFormSchema schema,
  required String notes,
  required String? photoPath,
  required bool hasCoordinates,
  required InspectionCondition? condition,
}) {
  String? notesError;
  String? photoError;
  String? locationError;
  String? conditionError;

  for (final field in schema.fields) {
    if (!field.required) {
      continue;
    }

    switch (field.type) {
      case InspectionFormFieldType.text when field.key == 'observation':
        final trimmedNotes = notes.trim();
        notesError = trimmedNotes.isEmpty
            ? 'A observação é obrigatória.'
            : validateInspectionNotes(
                notes,
                minLength: field.minLength ?? schema.observationMinLength,
              );
      case InspectionFormFieldType.photo:
        photoError =
            photoPath == null ? 'A foto da inspeção é obrigatória.' : null;
      case InspectionFormFieldType.location:
        locationError =
            hasCoordinates ? null : 'A localização GPS é obrigatória.';
      case InspectionFormFieldType.select when field.key == 'condition':
        conditionError =
            condition == null ? 'Selecione a condição do ativo.' : null;
      case InspectionFormFieldType.text:
      case InspectionFormFieldType.select:
      case InspectionFormFieldType.unknown:
        break;
    }
  }

  return InspectionCompletionValidation(
    notesError: notesError,
    photoError: photoError,
    locationError: locationError,
    conditionError: conditionError,
  );
}
