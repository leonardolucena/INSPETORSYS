import 'package:inspetorsys/core/connectivity/network_monitor.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/core/image/inspection_photo_resolver.dart';
import 'package:inspetorsys/core/utils/uuid_generator.dart';
import 'package:inspetorsys/features/inspections/data/datasources/inspection_local_data_source.dart';
import 'package:inspetorsys/features/inspections/data/datasources/inspection_remote_data_source.dart';
import 'package:inspetorsys/features/inspections/data/datasources/sync_queue_local_data_source.dart';
import 'package:inspetorsys/features/inspections/data/dto/inspection_dto.dart';
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
    this._remoteDataSource,
    this._syncQueueLocalDataSource,
    this._workOrderLocalDataSource,
    this._networkMonitor,
    this._uuidGenerator,
  );

  final InspectionLocalDataSource _localDataSource;
  final InspectionRemoteDataSource _remoteDataSource;
  final SyncQueueLocalDataSource _syncQueueLocalDataSource;
  final WorkOrderLocalDataSource _workOrderLocalDataSource;
  final NetworkMonitor _networkMonitor;
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
  Future<List<LocalInspectionListItem>> getCachedInspections({
    InspectionSyncStatus? status,
  }) async {
    final inspections = await _localDataSource.list(status: status);
    return Future.wait(inspections.map(_mapToListItem));
  }

  @override
  AppAsyncResult<List<LocalInspectionListItem>> getInspections({
    InspectionSyncStatus? status,
    bool forceRefresh = false,
  }) async {
    try {
      final hasInternet = await _networkMonitor.hasInternetAccess();

      if (!hasInternet) {
        final cached = await getCachedInspections(status: status);
        if (cached.isNotEmpty) {
          return appSuccess(cached);
        }

        return appFailure(const NetworkFailure());
      }

      try {
        final remoteItems = await _remoteDataSource.fetchInspections();
        await _mergeRemoteInspections(remoteItems);
      } on AppFailure catch (failure) {
        final cached = await getCachedInspections(status: status);
        if (cached.isNotEmpty) {
          return appSuccess(cached);
        }

        return appFailure(failure);
      }

      final cached = await getCachedInspections(status: status);
      return appSuccess(cached);
    } on AppFailure catch (failure) {
      return appFailure(failure);
    } catch (_) {
      return appFailure(const UnknownFailure());
    }
  }

  Future<void> _mergeRemoteInspections(List<InspectionDto> remoteItems) async {
    for (final dto in remoteItems) {
      await _mergeRemoteInspection(dto);
    }
  }

  Future<void> _mergeRemoteInspection(InspectionDto dto) async {
    final existing = await _localDataSource.getByClientId(dto.clientId);

    if (existing != null && _isLocalOnlyStatus(existing.status)) {
      return;
    }

    final workOrder =
        await _workOrderLocalDataSource.getWorkOrderById(dto.workOrderId);

    final photoPath = resolveInspectionPhotoPathForPersistence(
      localPhotoPath: existing?.photoPath,
      remotePhotoUrl: dto.photoUrl,
    );

    final inspection = dto
        .toDomain(
          status: InspectionSyncStatus.synced,
          photoPath: photoPath,
        )
        .copyWith(
          workOrderCode: workOrder?.code ?? existing?.workOrderCode,
          workOrderLatitude:
              workOrder?.latitude ?? existing?.workOrderLatitude,
          workOrderLongitude:
              workOrder?.longitude ?? existing?.workOrderLongitude,
          formSchema: existing?.formSchema,
        );

    await _localDataSource.upsert(inspection);
  }

  bool _isLocalOnlyStatus(InspectionSyncStatus status) =>
      status == InspectionSyncStatus.draft ||
      status == InspectionSyncStatus.pending ||
      status == InspectionSyncStatus.failed;

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
  Future<Inspection?> getCachedInspectionByClientId(String clientId) async {
    try {
      return await _localDataSource.getByClientId(clientId);
    } catch (_) {
      return null;
    }
  }

  @override
  AppAsyncResult<Inspection> getInspectionByClientId(String clientId) async {
    try {
      final hasInternet = await _networkMonitor.hasInternetAccess();

      if (!hasInternet) {
        final cached = await _localDataSource.getByClientId(clientId);
        if (cached != null) {
          return appSuccess(cached);
        }

        return appFailure(const NetworkFailure());
      }

      try {
        final remoteItem = await _remoteDataSource.fetchInspectionById(clientId);
        await _mergeRemoteInspection(remoteItem);

        final inspection = await _localDataSource.getByClientId(clientId);
        if (inspection != null) {
          return appSuccess(inspection);
        }

        return appFailure(
          const ValidationFailure(
            message: 'Inspeção não encontrada neste dispositivo.',
          ),
        );
      } on AppFailure catch (failure) {
        final cached = await _localDataSource.getByClientId(clientId);
        if (cached != null) {
          return appSuccess(cached);
        }

        return appFailure(failure);
      }
    } on AppFailure catch (failure) {
      return appFailure(failure);
    } catch (_) {
      return appFailure(const UnknownFailure());
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
