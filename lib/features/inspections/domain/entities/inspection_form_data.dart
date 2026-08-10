import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_condition.dart';

InspectionCondition? readInspectionCondition(Map<String, dynamic>? formData) {
  if (formData == null) {
    return null;
  }

  return InspectionConditionX.fromApiValue(formData['condition'] as String?);
}

InspectionCondition? inspectionCondition(Inspection inspection) {
  return readInspectionCondition(inspection.formData);
}

Map<String, dynamic>? buildInspectionFormData(InspectionCondition? condition) {
  if (condition == null) {
    return null;
  }

  return {
    'condition': condition.apiValue,
  };
}
