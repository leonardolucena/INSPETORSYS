import 'package:equatable/equatable.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_schema.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_condition.dart';

class SaveInspectionInput extends Equatable {
  const SaveInspectionInput({
    this.clientId,
    required this.workOrderId,
    required this.notes,
    this.photoPath,
    this.latitude,
    this.longitude,
    this.capturedAt,
    this.condition,
    this.createdAt,
    this.formSchema,
  });

  final String? clientId;
  final String workOrderId;
  final String notes;
  final String? photoPath;
  final double? latitude;
  final double? longitude;
  final DateTime? capturedAt;
  final InspectionCondition? condition;
  final DateTime? createdAt;
  final InspectionFormSchema? formSchema;

  @override
  List<Object?> get props => [
        clientId,
        workOrderId,
        notes,
        photoPath,
        latitude,
        longitude,
        capturedAt,
        condition,
        createdAt,
        formSchema,
      ];
}
