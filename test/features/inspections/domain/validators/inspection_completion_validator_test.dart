import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_schema.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_condition.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_form_field_type.dart';
import 'package:inspetorsys/features/inspections/domain/validators/inspection_completion_validator.dart';

const testFormSchema = InspectionFormSchema(
  workOrderId: 'wo_1001',
  fields: [
    InspectionFormFieldSchema(
      key: 'observation',
      type: InspectionFormFieldType.text,
      label: 'Observação',
      required: true,
      minLength: 10,
    ),
    InspectionFormFieldSchema(
      key: 'condition',
      type: InspectionFormFieldType.select,
      label: 'Condição do ativo',
      required: true,
      options: ['bom', 'regular', 'ruim', 'crítico'],
    ),
    InspectionFormFieldSchema(
      key: 'photo',
      type: InspectionFormFieldType.photo,
      label: 'Foto da evidência',
      required: true,
    ),
    InspectionFormFieldSchema(
      key: 'location',
      type: InspectionFormFieldType.location,
      label: 'Local da inspeção',
      required: true,
    ),
  ],
);

void main() {
  test('returns valid when all required fields are present', () {
    final validation = validateInspectionForCompletion(
      schema: testFormSchema,
      notes: 'Observação válida com mais de dez caracteres',
      photoPath: '/tmp/photo.jpg',
      hasCoordinates: true,
      condition: InspectionCondition.bom,
    );

    expect(validation.isValid, isTrue);
  });

  test('returns errors for missing required fields', () {
    final validation = validateInspectionForCompletion(
      schema: testFormSchema,
      notes: '',
      photoPath: null,
      hasCoordinates: false,
      condition: null,
    );

    expect(validation.isValid, isFalse);
    expect(validation.notesError, 'A observação é obrigatória.');
    expect(validation.photoError, 'A foto da inspeção é obrigatória.');
    expect(validation.locationError, 'A localização GPS é obrigatória.');
    expect(validation.conditionError, 'Selecione a condição do ativo.');
  });

  test('returns notes length error when observation is too short', () {
    final validation = validateInspectionForCompletion(
      schema: testFormSchema,
      notes: 'curta',
      photoPath: '/tmp/photo.jpg',
      hasCoordinates: true,
      condition: InspectionCondition.regular,
    );

    expect(
      validation.notesError,
      'A observação deve ter no mínimo 10 caracteres.',
    );
  });
}
