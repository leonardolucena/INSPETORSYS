import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_schema.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_form_field_type.dart';

/// Fallback schema matching the mock API contract when offline and no cache exists.
abstract final class DefaultInspectionFormSchema {
  static InspectionFormSchema forWorkOrder(String workOrderId) {
    return InspectionFormSchema(
      workOrderId: workOrderId,
      fields: const [
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
  }
}
