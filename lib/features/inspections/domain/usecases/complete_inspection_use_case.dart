import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/entities/save_inspection_input.dart';
import 'package:inspetorsys/features/inspections/domain/repositories/inspection_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompleteInspectionUseCase {
  CompleteInspectionUseCase(this._repository);

  final InspectionRepository _repository;

  AppAsyncResult<Inspection> call(SaveInspectionInput input) {
    return _repository.completeInspection(input);
  }
}
