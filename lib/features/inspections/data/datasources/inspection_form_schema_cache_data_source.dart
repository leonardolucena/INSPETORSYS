import 'package:inspetorsys/features/inspections/data/dto/inspection_form_schema_dto.dart';

abstract interface class InspectionFormSchemaCacheDataSource {
  Future<InspectionFormSchemaDto?> get(String workOrderId);

  Future<void> save(InspectionFormSchemaDto schema);

  Future<void> clearAll();
}
