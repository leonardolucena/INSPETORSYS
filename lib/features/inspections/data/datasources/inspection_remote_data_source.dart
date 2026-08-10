import 'package:inspetorsys/features/inspections/data/dto/inspection_dto.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';

abstract interface class InspectionRemoteDataSource {
  Future<List<InspectionDto>> fetchInspections();

  Future<InspectionDto> fetchInspectionById(String id);

  Future<InspectionDto> uploadInspection(Inspection inspection);
}
