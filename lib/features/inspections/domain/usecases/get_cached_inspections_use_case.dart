import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/entities/local_inspection_list_item.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';
import 'package:inspetorsys/features/inspections/domain/repositories/inspection_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCachedInspectionsUseCase {
  GetCachedInspectionsUseCase(this._repository);

  final InspectionRepository _repository;

  Future<List<LocalInspectionListItem>> call({
    InspectionSyncStatus? status,
  }) {
    return _repository.getCachedInspections(status: status);
  }
}

@injectable
class GetCachedInspectionByClientIdUseCase {
  GetCachedInspectionByClientIdUseCase(this._repository);

  final InspectionRepository _repository;

  Future<Inspection?> call(String clientId) {
    return _repository.getCachedInspectionByClientId(clientId);
  }
}
