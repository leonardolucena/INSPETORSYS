import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/entities/local_inspection_list_item.dart';
import 'package:inspetorsys/features/inspections/domain/entities/save_inspection_input.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';

abstract interface class InspectionRepository {
  AppAsyncResult<Inspection> saveDraft(SaveInspectionInput input);

  AppAsyncResult<Inspection> completeInspection(SaveInspectionInput input);

  Future<List<LocalInspectionListItem>> getCachedInspections({
    InspectionSyncStatus? status,
  });

  AppAsyncResult<List<LocalInspectionListItem>> getInspections({
    InspectionSyncStatus? status,
    bool forceRefresh = false,
  });

  AppAsyncResult<List<LocalInspectionListItem>> getLocalInspections({
    InspectionSyncStatus? status,
  });

  AppAsyncResult<int> getPendingInspectionsCount();

  AppAsyncResult<Inspection> retryFailedInspection(String clientId);

  Future<Inspection?> getCachedInspectionByClientId(String clientId);

  AppAsyncResult<Inspection> getLocalInspectionByClientId(String clientId);

  AppAsyncResult<Inspection> getInspectionByClientId(String clientId);
}
