import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';

abstract interface class InspectionLocalDataSource {
  Future<void> upsert(Inspection inspection);

  Future<Inspection?> getByClientId(String clientId);

  Future<List<Inspection>> list({InspectionSyncStatus? status});

  Future<int> countByStatus(InspectionSyncStatus status);
}
