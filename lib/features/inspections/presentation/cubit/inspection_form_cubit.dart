import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspetorsys/core/image/inspection_photo_resolver.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/failure_message_mapper.dart';
import 'package:inspetorsys/core/image/image_exception.dart';
import 'package:inspetorsys/core/location/geo_coordinates.dart';
import 'package:inspetorsys/core/location/geo_distance_calculator.dart';
import 'package:inspetorsys/core/location/location_exception.dart';
import 'package:inspetorsys/core/location/location_service.dart';
import 'package:inspetorsys/core/permissions/permission_service.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_schema.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_data.dart';
import 'package:inspetorsys/features/inspections/domain/entities/save_inspection_input.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_condition.dart';
import 'package:inspetorsys/features/inspections/domain/geofence/inspection_geofence.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/capture_inspection_location_use_case.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/capture_inspection_photo_use_case.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/complete_inspection_use_case.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/get_inspection_form_schema_use_case.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/get_local_inspection_by_client_id_use_case.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/save_inspection_draft_use_case.dart';
import 'package:inspetorsys/features/inspections/domain/validators/inspection_completion_validator.dart';
import 'package:inspetorsys/features/inspections/domain/validators/inspection_notes_validator.dart';
import 'package:inspetorsys/features/inspections/presentation/cubit/inspection_form_state.dart';
import 'package:inspetorsys/features/work_orders/domain/usecases/get_work_order_by_id_use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class InspectionFormCubit extends Cubit<InspectionFormState> {
  InspectionFormCubit(
    this._capturePhotoUseCase,
    this._captureLocationUseCase,
    this._getFormSchemaUseCase,
    this._getWorkOrderByIdUseCase,
    this._getLocalInspectionByClientIdUseCase,
    this._saveDraftUseCase,
    this._completeInspectionUseCase,
    this._geoDistanceCalculator,
    this._locationService,
    this._permissionService, {
    @factoryParam required String workOrderId,
    @factoryParam String? inspectionClientId,
  })  : _inspectionClientId = inspectionClientId,
        super(InspectionFormState(workOrderId: workOrderId));

  final CaptureInspectionPhotoUseCase _capturePhotoUseCase;
  final CaptureInspectionLocationUseCase _captureLocationUseCase;
  final GetInspectionFormSchemaUseCase _getFormSchemaUseCase;
  final GetWorkOrderByIdUseCase _getWorkOrderByIdUseCase;
  final GetLocalInspectionByClientIdUseCase _getLocalInspectionByClientIdUseCase;
  final SaveInspectionDraftUseCase _saveDraftUseCase;
  final CompleteInspectionUseCase _completeInspectionUseCase;
  final GeoDistanceCalculator _geoDistanceCalculator;
  final LocationService _locationService;
  final PermissionService _permissionService;
  final String? _inspectionClientId;

  Future<void> load() async {
    emit(
      state.copyWith(
        loadStatus: InspectionFormLoadStatus.loading,
        clearLoadErrorMessage: true,
      ),
    );

    Inspection? draftInspection;
    final inspectionClientId = _inspectionClientId;
    if (inspectionClientId != null) {
      final inspectionResult =
          await _getLocalInspectionByClientIdUseCase(inspectionClientId);

      final loadedDraft = inspectionResult.fold(
        (inspection) => inspection,
        (_) => null,
      );

      if (loadedDraft == null) {
        emit(
          state.copyWith(
            loadStatus: InspectionFormLoadStatus.failure,
            loadErrorMessage: 'Não foi possível abrir esta inspeção.',
          ),
        );
        return;
      }

      if (loadedDraft.workOrderId != state.workOrderId) {
        emit(
          state.copyWith(
            loadStatus: InspectionFormLoadStatus.failure,
            loadErrorMessage: 'Não foi possível abrir esta inspeção.',
          ),
        );
        return;
      }

      draftInspection = loadedDraft;
    }

    InspectionFormSchema? schema = draftInspection?.formSchema;
    if (schema == null) {
      final schemaResult = await _getFormSchemaUseCase(state.workOrderId);
      final resolvedSchema = schemaResult.fold(
        (value) => value,
        (_) => null,
      );

      if (resolvedSchema == null) {
        final errorMessage = schemaResult.fold(
          (_) => 'Não foi possível carregar o formulário.',
          (failure) => failure.message,
        );

        emit(
          state.copyWith(
            loadStatus: InspectionFormLoadStatus.failure,
            loadErrorMessage: errorMessage,
          ),
        );
        return;
      }

      schema = resolvedSchema;
    }

    final workOrderResult = await _getWorkOrderByIdUseCase(state.workOrderId);
    final workOrder = workOrderResult.fold(
      (value) => value,
      (_) => null,
    );

    final workOrderLatitude =
        workOrder?.latitude ?? draftInspection?.workOrderLatitude;
    final workOrderLongitude =
        workOrder?.longitude ?? draftInspection?.workOrderLongitude;

    if (workOrder == null && workOrderLatitude == null && draftInspection == null) {
      final errorMessage = workOrderResult.fold(
        (_) => 'Não foi possível carregar a ordem de serviço.',
        (failure) => failure.message,
      );

      emit(
        state.copyWith(
          loadStatus: InspectionFormLoadStatus.failure,
          formSchema: schema,
          loadErrorMessage: errorMessage,
        ),
      );
      return;
    }

    var nextState = state.copyWith(
      loadStatus: InspectionFormLoadStatus.success,
      formSchema: schema,
      workOrderLatitude: workOrderLatitude,
      workOrderLongitude: workOrderLongitude,
      clearLoadErrorMessage: true,
    );

    if (draftInspection != null) {
      nextState = _mapInspectionToFormState(nextState, draftInspection);
    }

    emit(nextState);
  }

  InspectionFormState _mapInspectionToFormState(
    InspectionFormState base,
    Inspection inspection,
  ) {
    GeoCoordinates? coordinates;
    if (inspection.latitude != null && inspection.longitude != null) {
      coordinates = GeoCoordinates(
        latitude: inspection.latitude!,
        longitude: inspection.longitude!,
        capturedAt: inspection.capturedAt,
      );
    }

    final geofenceState = coordinates == null
        ? const _GeofenceState()
        : _buildGeofenceState(coordinates);
    final photoPath = _resolveExistingPhotoPath(inspection.photoPath);

    return base.copyWith(
      clientId: inspection.clientId,
      notes: inspection.notes ?? '',
      photoPath: photoPath,
      photoSizeBytes: _readPhotoSizeBytes(photoPath),
      coordinates: coordinates,
      condition: inspectionCondition(inspection),
      createdAt: inspection.createdAt,
      geofenceWarning: geofenceState.warning,
      distanceFromWorkOrderMeters: geofenceState.distanceMeters,
      clearGeofenceWarning: geofenceState.warning == null,
      clearNotesError: true,
      clearPhotoError: true,
      clearLocationError: true,
      clearConditionError: true,
    );
  }

  String? _resolveExistingPhotoPath(String? photoPath) {
    if (photoPath == null || photoPath.isEmpty) {
      return null;
    }

    final source = resolveInspectionPhotoSource(photoPath);
    if (source == null) {
      return null;
    }

    return switch (source.type) {
      InspectionPhotoSourceType.file => source.path,
      InspectionPhotoSourceType.network => source.networkUrl,
    };
  }

  int? _readPhotoSizeBytes(String? photoPath) {
    if (photoPath == null) {
      return null;
    }

    final source = resolveInspectionPhotoSource(photoPath);
    if (source?.type != InspectionPhotoSourceType.file || source?.path == null) {
      return null;
    }

    final file = File(source!.path!);
    if (!file.existsSync()) {
      return null;
    }

    return file.lengthSync();
  }

  void onNotesChanged(String value) {
    final notesValidation = validateInspectionNotesOnBlur(
      value,
      minLength: state.observationMinLength,
    );

    emit(
      state.copyWith(
        notes: value,
        clearNotesError: state.notesError != null && notesValidation == null,
        clearSaveErrorMessage: true,
      ),
    );
  }

  void validateNotesField() {
    final notesValidation = validateInspectionNotesOnBlur(
      state.notes,
      minLength: state.observationMinLength,
    );

    emit(
      state.copyWith(
        notesError: notesValidation,
        clearNotesError: notesValidation == null,
      ),
    );
  }

  void onConditionChanged(InspectionCondition? condition) {
    emit(
      state.copyWith(
        condition: condition,
        clearCondition: condition == null,
        clearConditionError: true,
        clearSaveErrorMessage: true,
      ),
    );
  }

  Future<void> capturePhoto() async {
    if (state.isCapturingPhoto) {
      return;
    }

    emit(state.copyWith(isCapturingPhoto: true, clearPhotoError: true));

    try {
      final image = await _capturePhotoUseCase();

      emit(
        state.copyWith(
          isCapturingPhoto: false,
          photoPath: image.path,
          photoSizeBytes: image.sizeBytes,
          clearPhotoError: true,
        ),
      );
    } on ImageCaptureCancelledException {
      emit(state.copyWith(isCapturingPhoto: false));
    } on ImagePermissionDeniedException {
      emit(state.copyWith(isCapturingPhoto: false));
      rethrow;
    } on ImageException {
      emit(state.copyWith(isCapturingPhoto: false));
      rethrow;
    } catch (_) {
      emit(state.copyWith(isCapturingPhoto: false));
      rethrow;
    }
  }

  Future<void> captureLocation() async {
    if (state.isCapturingLocation) {
      return;
    }

    emit(
      state.copyWith(
        isCapturingLocation: true,
        clearLocationError: true,
        showLocationSettingsAction: false,
        clearGeofenceWarning: true,
      ),
    );

    try {
      final coordinates = await _captureLocationUseCase();
      final geofenceState = _buildGeofenceState(coordinates);

      emit(
        state.copyWith(
          isCapturingLocation: false,
          coordinates: coordinates,
          clearLocationError: true,
          showLocationSettingsAction: false,
          geofenceWarning: geofenceState.warning,
          distanceFromWorkOrderMeters: geofenceState.distanceMeters,
          clearGeofenceWarning: geofenceState.warning == null,
        ),
      );
    } on AppLocationPermissionDeniedException {
      emit(
        state.copyWith(
          isCapturingLocation: false,
          locationError: 'Permissão de localização negada.',
          showLocationSettingsAction: true,
        ),
      );
    } on AppLocationServiceDisabledException {
      emit(
        state.copyWith(
          isCapturingLocation: false,
          locationError: 'Ative o serviço de localização do dispositivo.',
          showLocationSettingsAction: true,
        ),
      );
    } on LocationException catch (error) {
      emit(
        state.copyWith(
          isCapturingLocation: false,
          locationError: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isCapturingLocation: false,
          locationError: 'Não foi possível obter a localização.',
        ),
      );
    }
  }

  Future<void> openLocationSettings() async {
    if (state.showLocationSettingsAction) {
      final serviceEnabled = await _locationService.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await _locationService.openLocationSettings();
        return;
      }

      await _permissionService.openSettings();
    }
  }

  Future<void> saveDraft() async {
    if (state.isSaving || state.formSchema == null) {
      return;
    }

    emit(
      state.copyWith(
        saveStatus: InspectionFormSaveStatus.saving,
        clearSaveErrorMessage: true,
      ),
    );

    final result = await _saveDraftUseCase(_buildInput());

    result.fold(
      (inspection) => emit(
        state.copyWith(
          clientId: inspection.clientId,
          createdAt: inspection.createdAt,
          saveStatus: InspectionFormSaveStatus.draftSaved,
          clearSaveErrorMessage: true,
        ),
      ),
      (failure) => emit(
        state.copyWith(
          saveStatus: InspectionFormSaveStatus.failure,
          saveErrorMessage: mapFailureToUserMessage(
            failure,
            context: FailureMessageContext.inspectionForm,
          ),
        ),
      ),
    );
  }

  Future<void> completeInspection() async {
    if (state.isSaving || state.formSchema == null) {
      return;
    }

    final validation = validateInspectionForCompletion(
      schema: state.formSchema!,
      notes: state.notes,
      photoPath: state.photoPath,
      hasCoordinates: state.coordinates != null,
      condition: state.condition,
    );

    if (!validation.isValid) {
      emit(
        state.copyWith(
          notesError: validation.notesError ?? state.notesError,
          photoError: validation.photoError,
          locationError: validation.locationError ?? state.locationError,
          conditionError: validation.conditionError,
          saveStatus: InspectionFormSaveStatus.failure,
          saveErrorMessage: 'Preencha todos os campos obrigatórios.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        saveStatus: InspectionFormSaveStatus.saving,
        clearSaveErrorMessage: true,
        clearPhotoError: true,
        clearConditionError: true,
      ),
    );

    final result = await _completeInspectionUseCase(_buildInput());

    result.fold(
      (inspection) => emit(
        state.copyWith(
          clientId: inspection.clientId,
          createdAt: inspection.createdAt,
          saveStatus: InspectionFormSaveStatus.completed,
          clearSaveErrorMessage: true,
        ),
      ),
      (failure) {
        if (failure is ValidationFailure) {
          emit(
            state.copyWith(
              saveStatus: InspectionFormSaveStatus.failure,
              saveErrorMessage: failure.message,
              notesError: failure.fieldErrors['notes'] ?? state.notesError,
              photoError: failure.fieldErrors['photo'],
              locationError:
                  failure.fieldErrors['location'] ?? state.locationError,
              conditionError: failure.fieldErrors['condition'],
            ),
          );
          return;
        }

        emit(
          state.copyWith(
            saveStatus: InspectionFormSaveStatus.failure,
            saveErrorMessage: mapFailureToUserMessage(
            failure,
            context: FailureMessageContext.inspectionForm,
          ),
          ),
        );
      },
    );
  }

  void resetSaveStatus() {
    if (state.saveStatus == InspectionFormSaveStatus.draftSaved ||
        state.saveStatus == InspectionFormSaveStatus.completed ||
        state.saveStatus == InspectionFormSaveStatus.failure) {
      emit(
        state.copyWith(
          saveStatus: InspectionFormSaveStatus.idle,
          clearSaveErrorMessage: true,
        ),
      );
    }
  }

  SaveInspectionInput _buildInput() {
    return SaveInspectionInput(
      clientId: state.clientId,
      workOrderId: state.workOrderId,
      notes: state.notes,
      photoPath: state.photoPath,
      latitude: state.coordinates?.latitude,
      longitude: state.coordinates?.longitude,
      capturedAt: state.coordinates?.capturedAt,
      condition: state.condition,
      createdAt: state.createdAt,
      formSchema: state.formSchema,
    );
  }

  _GeofenceState _buildGeofenceState(GeoCoordinates coordinates) {
    final workOrderLatitude = state.workOrderLatitude;
    final workOrderLongitude = state.workOrderLongitude;

    if (workOrderLatitude == null || workOrderLongitude == null) {
      return const _GeofenceState();
    }

    final distanceMeters = _geoDistanceCalculator.distanceInMeters(
      startLatitude: coordinates.latitude,
      startLongitude: coordinates.longitude,
      endLatitude: workOrderLatitude,
      endLongitude: workOrderLongitude,
    );

    return _GeofenceState(
      distanceMeters: distanceMeters,
      warning: buildGeofenceWarningMessage(
        workOrderLatitude: workOrderLatitude,
        workOrderLongitude: workOrderLongitude,
        distanceMeters: distanceMeters,
      ),
    );
  }
}

class _GeofenceState {
  const _GeofenceState({
    this.distanceMeters,
    this.warning,
  });

  final double? distanceMeters;
  final String? warning;
}
