import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/core/utils/uuid_generator.dart';
import 'package:inspetorsys/features/inspections/data/datasources/inspection_local_data_source.dart';
import 'package:inspetorsys/features/inspections/data/datasources/sync_queue_local_data_source.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_data.dart';
import 'package:inspetorsys/features/inspections/domain/entities/local_inspection_list_item.dart';
import 'package:inspetorsys/features/inspections/domain/entities/save_inspection_input.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';
import 'package:inspetorsys/features/inspections/domain/repositories/inspection_repository.dart';
import 'package:inspetorsys/features/inspections/domain/validators/inspection_completion_validator.dart';
import 'package:inspetorsys/features/work_orders/data/datasources/work_order_local_data_source.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: InspectionRepository)
class InspectionRepositoryImpl implements InspectionRepository {
  InspectionRepositoryImpl(
    this._localDataSource,
    this._syncQueueLocalDataSource,
    this._workOrderLocalDataSource,
    this._uuidGenerator,
  );

  final InspectionLocalDataSource _localDataSource;
  final SyncQueueLocalDataSource _syncQueueLocalDataSource;
  final WorkOrderLocalDataSource _workOrderLocalDataSource;
  final UuidGenerator _uuidGenerator;

  @override
  AppAsyncResult<Inspection> saveDraft(SaveInspectionInput input) async {
    try {
      final inspection = await _persistInspection(
        input: input,
        status: InspectionSyncStatus.draft,
      );

      await _syncQueueLocalDataSource.removeByInspectionClientId(
        inspection.clientId,
      );

      return appSuccess(inspection);
    } catch (_) {
      return appFailure(const CacheFailure());
    }
  }

  @override
  AppAsyncResult<Inspection> completeInspection(SaveInspectionInput input) async {
    if (input.formSchema == null) {
      return appFailure(
        const ValidationFailure(
          message: 'Formulário da inspeção não carregado.',
        ),
      );
    }

    final validation = validateInspectionForCompletion(
      schema: input.formSchema!,
      notes: input.notes,
      photoPath: input.photoPath,
      hasCoordinates: input.latitude != null && input.longitude != null,
      condition: input.condition,
    );

    if (!validation.isValid) {
      return appFailure(
        ValidationFailure(
          message: 'Preencha todos os campos obrigatórios.',
          fieldErrors: {
            if (validation.notesError != null) 'notes': validation.notesError!,
            if (validation.photoError != null) 'photo': validation.photoError!,
            if (validation.locationError != null)
              'location': validation.locationError!,
            if (validation.conditionError != null)
              'condition': validation.conditionError!,
          },
        ),
      );
    }

    try {
      final inspection = await _persistInspection(
        input: input,
        status: InspectionSyncStatus.pending,
      );

      await _syncQueueLocalDataSource.enqueueInspection(inspection.clientId);

      return appSuccess(inspection);
    } catch (_) {
      return appFailure(const CacheFailure());
    }
  }

  Future<Inspection> _persistInspection({
    required SaveInspectionInput input,
    required InspectionSyncStatus status,
  }) async {
    final clientId = input.clientId ?? _uuidGenerator.generateClientId();
    final existing = await _localDataSource.getByClientId(clientId);
    final workOrder =
        await _workOrderLocalDataSource.getWorkOrderById(input.workOrderId);
    final now = DateTime.now();
    final trimmedNotes = input.notes.trim();

    final inspection = Inspection(
      clientId: clientId,
      serverId: existing?.serverId,
      workOrderId: input.workOrderId,
      workOrderCode: workOrder?.code ?? existing?.workOrderCode,
      workOrderLatitude: workOrder?.latitude ?? existing?.workOrderLatitude,
      workOrderLongitude: workOrder?.longitude ?? existing?.workOrderLongitude,
      status: status,
      notes: trimmedNotes.isEmpty ? null : trimmedNotes,
      photoPath: input.photoPath,
      latitude: input.latitude,
      longitude: input.longitude,
      capturedAt: input.capturedAt,
      formData: buildInspectionFormData(input.condition),
      formSchema: input.formSchema ?? existing?.formSchema,
      syncErrorMessage: null,
      createdAt: input.createdAt ?? existing?.createdAt ?? now,
      updatedAt: now,
      syncedAt: existing?.syncedAt,
    );

    await _localDataSource.upsert(inspection);
    return inspection;
  }

  @override
  AppAsyncResult<List<LocalInspectionListItem>> getLocalInspections({
    InspectionSyncStatus? status,
  }) async {
    try {
      final inspections = await _localDataSource.list(status: status);
      final items = await Future.wait(
        inspections.map(_mapToListItem),
      );

      return appSuccess(items);
    } catch (_) {
      return appFailure(const CacheFailure());
    }
  }

  Future<LocalInspectionListItem> _mapToListItem(Inspection inspection) async {
    final workOrder =
        await _workOrderLocalDataSource.getWorkOrderById(inspection.workOrderId);

    return LocalInspectionListItem(
      inspection: inspection,
      workOrderCode: workOrder?.code ?? inspection.workOrderCode,
      workOrderTitle: workOrder?.title,
    );
  }

  @override
  AppAsyncResult<int> getPendingInspectionsCount() async {
    try {
      final count = await _localDataSource.countByStatus(
        InspectionSyncStatus.pending,
      );
      return appSuccess(count);
    } catch (_) {
      return appFailure(const CacheFailure());
    }
  }

  @override
  AppAsyncResult<Inspection> getLocalInspectionByClientId(String clientId) async {
    try {
      final inspection = await _localDataSource.getByClientId(clientId);

      if (inspection == null) {
        return appFailure(
          const ValidationFailure(
            message: 'Inspeção não encontrada neste dispositivo.',
          ),
        );
      }

      return appSuccess(inspection);
    } catch (_) {
      return appFailure(const CacheFailure());
    }
  }

  @override
  AppAsyncResult<Inspection> retryFailedInspection(String clientId) async {
    try {
      final inspection = await _localDataSource.getByClientId(clientId);

      if (inspection == null) {
        return appFailure(
          const ValidationFailure(
            message: 'Inspeção não encontrada neste dispositivo.',
          ),
        );
      }

      if (inspection.status != InspectionSyncStatus.failed) {
        return appFailure(
          const ValidationFailure(
            message: 'Somente inspeções com falha podem ser reenviadas.',
          ),
        );
      }

      final pendingInspection = inspection.copyWith(
        status: InspectionSyncStatus.pending,
        syncErrorMessage: null,
        updatedAt: DateTime.now(),
      );

      await _localDataSource.upsert(pendingInspection);
      await _syncQueueLocalDataSource.enqueueInspection(clientId);

      return appSuccess(pendingInspection);
    } catch (_) {
      return appFailure(const CacheFailure());
    }
  }
}
