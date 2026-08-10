import 'package:inspetorsys/features/sync/domain/entities/inspection_sync_result.dart';
import 'package:inspetorsys/features/sync/domain/services/inspection_sync_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class SyncPendingInspectionsUseCase {
  SyncPendingInspectionsUseCase(this._inspectionSyncService);

  final InspectionSyncService _inspectionSyncService;

  Future<InspectionSyncResult> call() {
    return _inspectionSyncService.processQueue();
  }
}
