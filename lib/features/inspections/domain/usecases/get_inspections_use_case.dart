import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/features/inspections/domain/entities/local_inspection_list_item.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';
import 'package:inspetorsys/features/inspections/domain/repositories/inspection_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetInspectionsUseCase {
  GetInspectionsUseCase(this._repository);

  final InspectionRepository _repository;

  AppAsyncResult<List<LocalInspectionListItem>> call({
    InspectionSyncStatus? status,
    bool forceRefresh = false,
  }) {
    return _repository.getInspections(
      status: status,
      forceRefresh: forceRefresh,
    );
  }
}
