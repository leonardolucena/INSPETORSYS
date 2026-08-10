import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/repositories/inspection_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetInspectionByClientIdUseCase {
  GetInspectionByClientIdUseCase(this._repository);

  final InspectionRepository _repository;

  AppAsyncResult<Inspection> call(String clientId) {
    return _repository.getInspectionByClientId(clientId);
  }
}
