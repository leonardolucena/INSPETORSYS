import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/image/inspection_photo_resolver.dart';
import 'package:inspetorsys/features/inspections/data/datasources/inspection_local_data_source.dart';
import 'package:inspetorsys/features/inspections/data/datasources/inspection_remote_data_source.dart';
import 'package:inspetorsys/features/inspections/data/datasources/sync_queue_local_data_source.dart';
import 'package:inspetorsys/features/inspections/data/dto/inspection_dto.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/entities/sync_queue_item.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';
import 'package:inspetorsys/features/sync/domain/entities/inspection_sync_result.dart';
import 'package:inspetorsys/features/sync/domain/policies/sync_backoff_policy.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InspectionSyncService {
  InspectionSyncService(
    this._syncQueueLocalDataSource,
    this._inspectionLocalDataSource,
    this._inspectionRemoteDataSource,
  );

  final SyncQueueLocalDataSource _syncQueueLocalDataSource;
  final InspectionLocalDataSource _inspectionLocalDataSource;
  final InspectionRemoteDataSource _inspectionRemoteDataSource;

  Future<InspectionSyncResult> processQueue() async {
    final queueItems = await _syncQueueLocalDataSource.getProcessableItems();

    var processed = 0;
    var synced = 0;
    var keptPending = 0;
    var markedFailed = 0;
    var skipped = 0;

    for (final queueItem in queueItems) {
      final inspection = await _inspectionLocalDataSource.getByClientId(
        queueItem.inspectionClientId,
      );

      if (inspection == null) {
        await _syncQueueLocalDataSource.removeById(queueItem.id);
        skipped++;
        continue;
      }

      if (inspection.status == InspectionSyncStatus.draft ||
          inspection.status == InspectionSyncStatus.synced) {
        await _syncQueueLocalDataSource.removeById(queueItem.id);
        skipped++;
        continue;
      }

      if (inspection.status != InspectionSyncStatus.pending &&
          inspection.status != InspectionSyncStatus.failed) {
        skipped++;
        continue;
      }

      processed++;

      try {
        final response = await _inspectionRemoteDataSource.uploadInspection(
          inspection,
        );

        await _persistSyncedInspection(
          inspection: inspection,
          response: response,
        );
        await _syncQueueLocalDataSource.removeById(queueItem.id);
        synced++;
      } on ValidationFailure catch (failure) {
        await _markInspectionAsNonRecoverableFailure(
          inspection: inspection,
          queueItem: queueItem,
          message: failure.message,
        );
        markedFailed++;
      } on ConflictFailure catch (failure) {
        await _markInspectionAsNonRecoverableFailure(
          inspection: inspection,
          queueItem: queueItem,
          message: failure.message,
        );
        markedFailed++;
      } on NetworkFailure catch (failure) {
        await _handleRecoverableFailure(
          inspection: inspection,
          queueItem: queueItem,
          message: failure.message,
          onKeptPending: () => keptPending++,
          onMarkedFailed: () => markedFailed++,
        );
      } on AppFailure catch (failure) {
        await _handleRecoverableFailure(
          inspection: inspection,
          queueItem: queueItem,
          message: failure.message,
          onKeptPending: () => keptPending++,
          onMarkedFailed: () => markedFailed++,
        );
      }
    }

    return InspectionSyncResult(
      processed: processed,
      synced: synced,
      keptPending: keptPending,
      markedFailed: markedFailed,
      skipped: skipped,
    );
  }

  Future<void> _persistSyncedInspection({
    required Inspection inspection,
    required InspectionDto response,
  }) async {
    final photoPath = resolveInspectionPhotoPathForPersistence(
      localPhotoPath: inspection.photoPath,
      remotePhotoUrl: response.photoUrl,
    );

    final syncedInspection = response.toDomain(
      status: InspectionSyncStatus.synced,
      photoPath: photoPath,
    );

    await _inspectionLocalDataSource.upsert(syncedInspection);
  }

  Future<void> _markInspectionAsNonRecoverableFailure({
    required Inspection inspection,
    required SyncQueueItem queueItem,
    required String message,
  }) async {
    await _inspectionLocalDataSource.upsert(
      inspection.copyWith(
        status: InspectionSyncStatus.failed,
        syncErrorMessage: message,
        updatedAt: DateTime.now(),
      ),
    );
    await _syncQueueLocalDataSource.removeById(queueItem.id);
  }

  Future<void> _handleRecoverableFailure({
    required Inspection inspection,
    required SyncQueueItem queueItem,
    required String message,
    required void Function() onKeptPending,
    required void Function() onMarkedFailed,
  }) async {
    final nextRetryCount = queueItem.retryCount + 1;

    if (SyncBackoffPolicy.hasExceededMaxRetries(nextRetryCount)) {
      await _inspectionLocalDataSource.upsert(
        inspection.copyWith(
          status: InspectionSyncStatus.failed,
          syncErrorMessage:
              'Limite de tentativas de sincronização excedido. $message',
          updatedAt: DateTime.now(),
        ),
      );
      await _syncQueueLocalDataSource.removeById(queueItem.id);
      onMarkedFailed();
      return;
    }

    await _inspectionLocalDataSource.upsert(
      inspection.copyWith(
        status: InspectionSyncStatus.pending,
        syncErrorMessage: message,
        updatedAt: DateTime.now(),
      ),
    );
    await _syncQueueLocalDataSource.recordNetworkFailure(
      id: queueItem.id,
      errorMessage: message,
      retryCount: nextRetryCount,
      nextRetryAt: SyncBackoffPolicy.nextRetryAtForAttempt(nextRetryCount),
    );
    onKeptPending();
  }
}
