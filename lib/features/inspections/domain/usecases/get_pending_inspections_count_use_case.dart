import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/features/inspections/domain/repositories/inspection_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPendingInspectionsCountUseCase {
  GetPendingInspectionsCountUseCase(this._repository);

  final InspectionRepository _repository;

  AppAsyncResult<int> call() {
    return _repository.getPendingInspectionsCount();
  }
}
