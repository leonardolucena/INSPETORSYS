import 'package:equatable/equatable.dart';
import 'package:inspetorsys/core/location/geo_coordinates.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_schema.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_condition.dart';

enum InspectionFormSaveStatus {
  idle,
  saving,
  draftSaved,
  completed,
  failure,
}

enum InspectionFormLoadStatus {
  initial,
  loading,
  success,
  failure,
}

class InspectionFormState extends Equatable {
  const InspectionFormState({
    required this.workOrderId,
    this.clientId,
    this.loadStatus = InspectionFormLoadStatus.initial,
    this.formSchema,
    this.loadErrorMessage,
    this.workOrderLatitude,
    this.workOrderLongitude,
    this.notes = '',
    this.notesError,
    this.photoPath,
    this.photoSizeBytes,
    this.photoError,
    this.isCapturingPhoto = false,
    this.coordinates,
    this.isCapturingLocation = false,
    this.locationError,
    this.showLocationSettingsAction = false,
    this.geofenceWarning,
    this.distanceFromWorkOrderMeters,
    this.condition,
    this.conditionError,
    this.saveStatus = InspectionFormSaveStatus.idle,
    this.saveErrorMessage,
    this.createdAt,
  });

  final String workOrderId;
  final String? clientId;
  final InspectionFormLoadStatus loadStatus;
  final InspectionFormSchema? formSchema;
  final String? loadErrorMessage;
  final double? workOrderLatitude;
  final double? workOrderLongitude;
  final String notes;
  final String? notesError;
  final String? photoPath;
  final int? photoSizeBytes;
  final String? photoError;
  final bool isCapturingPhoto;
  final GeoCoordinates? coordinates;
  final bool isCapturingLocation;
  final String? locationError;
  final bool showLocationSettingsAction;
  final String? geofenceWarning;
  final double? distanceFromWorkOrderMeters;
  final InspectionCondition? condition;
  final String? conditionError;
  final InspectionFormSaveStatus saveStatus;
  final String? saveErrorMessage;
  final DateTime? createdAt;

  bool get isSaving => saveStatus == InspectionFormSaveStatus.saving;

  bool get isLoading => loadStatus == InspectionFormLoadStatus.loading;

  int get observationMinLength =>
      formSchema?.observationMinLength ?? 10;

  InspectionFormState copyWith({
    String? clientId,
    InspectionFormLoadStatus? loadStatus,
    InspectionFormSchema? formSchema,
    String? loadErrorMessage,
    double? workOrderLatitude,
    double? workOrderLongitude,
    String? notes,
    String? notesError,
    String? photoPath,
    int? photoSizeBytes,
    String? photoError,
    bool? isCapturingPhoto,
    GeoCoordinates? coordinates,
    bool? isCapturingLocation,
    String? locationError,
    bool? showLocationSettingsAction,
    String? geofenceWarning,
    double? distanceFromWorkOrderMeters,
    InspectionCondition? condition,
    String? conditionError,
    InspectionFormSaveStatus? saveStatus,
    String? saveErrorMessage,
    DateTime? createdAt,
    bool clearNotesError = false,
    bool clearPhoto = false,
    bool clearPhotoError = false,
    bool clearCoordinates = false,
    bool clearLocationError = false,
    bool clearGeofenceWarning = false,
    bool clearCondition = false,
    bool clearConditionError = false,
    bool clearSaveErrorMessage = false,
    bool clearLoadErrorMessage = false,
    bool clearWorkOrderCoordinates = false,
  }) {
    return InspectionFormState(
      workOrderId: workOrderId,
      clientId: clientId ?? this.clientId,
      loadStatus: loadStatus ?? this.loadStatus,
      formSchema: formSchema ?? this.formSchema,
      loadErrorMessage:
          clearLoadErrorMessage ? null : (loadErrorMessage ?? this.loadErrorMessage),
      workOrderLatitude: clearWorkOrderCoordinates
          ? null
          : (workOrderLatitude ?? this.workOrderLatitude),
      workOrderLongitude: clearWorkOrderCoordinates
          ? null
          : (workOrderLongitude ?? this.workOrderLongitude),
      notes: notes ?? this.notes,
      notesError: clearNotesError ? null : (notesError ?? this.notesError),
      photoPath: clearPhoto ? null : (photoPath ?? this.photoPath),
      photoSizeBytes:
          clearPhoto ? null : (photoSizeBytes ?? this.photoSizeBytes),
      photoError: clearPhotoError ? null : (photoError ?? this.photoError),
      isCapturingPhoto: isCapturingPhoto ?? this.isCapturingPhoto,
      coordinates: clearCoordinates ? null : (coordinates ?? this.coordinates),
      isCapturingLocation: isCapturingLocation ?? this.isCapturingLocation,
      locationError:
          clearLocationError ? null : (locationError ?? this.locationError),
      showLocationSettingsAction:
          showLocationSettingsAction ?? this.showLocationSettingsAction,
      geofenceWarning:
          clearGeofenceWarning ? null : (geofenceWarning ?? this.geofenceWarning),
      distanceFromWorkOrderMeters: clearGeofenceWarning
          ? null
          : (distanceFromWorkOrderMeters ?? this.distanceFromWorkOrderMeters),
      condition: clearCondition ? null : (condition ?? this.condition),
      conditionError:
          clearConditionError ? null : (conditionError ?? this.conditionError),
      saveStatus: saveStatus ?? this.saveStatus,
      saveErrorMessage: clearSaveErrorMessage
          ? null
          : (saveErrorMessage ?? this.saveErrorMessage),
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        workOrderId,
        clientId,
        loadStatus,
        formSchema,
        loadErrorMessage,
        workOrderLatitude,
        workOrderLongitude,
        notes,
        notesError,
        photoPath,
        photoSizeBytes,
        photoError,
        isCapturingPhoto,
        coordinates,
        isCapturingLocation,
        locationError,
        showLocationSettingsAction,
        geofenceWarning,
        distanceFromWorkOrderMeters,
        condition,
        conditionError,
        saveStatus,
        saveErrorMessage,
        createdAt,
      ];
}
