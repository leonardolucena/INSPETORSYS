// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'InspetorSYS';

  @override
  String get appSlogan => 'FIELD INSPECTION SYSTEM';

  @override
  String get drawerWorkOrders => 'Work orders';

  @override
  String get drawerInspectionsHistory => 'Inspection history';

  @override
  String get drawerSyncInspections => 'Sync inspections';

  @override
  String get drawerLanguage => 'Language';

  @override
  String get drawerDarkMode => 'Dark mode';

  @override
  String get languagePortuguese => 'Português';

  @override
  String get languageEnglish => 'English';

  @override
  String get userFallback => 'User';

  @override
  String get connectionOnline => 'Online';

  @override
  String get connectionNoInternet => 'No internet';

  @override
  String get connectionOffline => 'Offline';

  @override
  String get loginEmailLabel => 'Email';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginSubmitting => 'SIGNING IN...';

  @override
  String get loginSubmit => 'SIGN IN';

  @override
  String get loginInvalidCredentials => 'Invalid email or password.';

  @override
  String get workOrdersTitle => 'Work orders';

  @override
  String get workOrdersLoadError => 'Could not load work orders.';

  @override
  String get workOrdersEmptyTitle => 'No work orders';

  @override
  String get workOrdersEmptyMessageAll =>
      'There are no work orders available at the moment.';

  @override
  String get workOrdersEmptyMessageFiltered =>
      'No work orders match the selected filter.';

  @override
  String get refreshAction => 'Refresh';

  @override
  String get retryAction => 'Try again';

  @override
  String get filterAll => 'All';

  @override
  String get workOrderStatusOpen => 'Open';

  @override
  String get workOrderStatusInProgress => 'In progress';

  @override
  String get workOrderStatusDone => 'Done';

  @override
  String get workOrderPriorityHigh => 'High';

  @override
  String get workOrderPriorityMedium => 'Medium';

  @override
  String get workOrderPriorityLow => 'Low';

  @override
  String get workOrderDetailTitle => 'Work order details';

  @override
  String get workOrderDetailLoadError => 'Could not load the work order.';

  @override
  String get workOrderDescriptionLabel => 'Description:';

  @override
  String get workOrderAddressLabel => 'Address:';

  @override
  String get workOrderNotesLabel => 'Notes:';

  @override
  String get workOrderScheduledForLabel => 'Scheduled for';

  @override
  String get workOrderUpdatedAtLabel => 'Updated at';

  @override
  String get workOrderLocationTitle => 'Location';

  @override
  String get workOrderNewInspection => 'New inspection';

  @override
  String get inspectionsHistoryTitle => 'Inspection history';

  @override
  String get inspectionsLoadError => 'Could not load local inspections.';

  @override
  String get inspectionsEmptyTitle => 'No inspections found';

  @override
  String get inspectionsEmptyMessageAll =>
      'You have not recorded any inspections on this device yet.';

  @override
  String get inspectionsEmptyMessageFiltered =>
      'No inspections match the selected status.';

  @override
  String get inspectionNotEditable =>
      'This inspection is already completed and cannot be edited.';

  @override
  String get inspectionRetryQueued => 'Inspection queued for sync again.';

  @override
  String get inspectionRetryFailed => 'Could not retry the inspection.';

  @override
  String get syncStatusDraft => 'Draft';

  @override
  String get syncStatusPending => 'Pending';

  @override
  String get syncStatusSynced => 'Sent';

  @override
  String get syncStatusFailed => 'Failed';

  @override
  String get inspectionFormNewTitle => 'New inspection';

  @override
  String get inspectionFormContinueTitle => 'Continue inspection';

  @override
  String get inspectionFormLoadError => 'Could not load the inspection form.';

  @override
  String get inspectionFormFieldObservation => 'Observation';

  @override
  String get inspectionFormFieldCondition => 'Asset condition';

  @override
  String get inspectionFormFieldPhoto => 'Evidence photo';

  @override
  String get inspectionFormFieldLocation => 'Inspection location';

  @override
  String get inspectionFormSavingDraft => 'Saving...';

  @override
  String get inspectionFormSaveDraft => 'Save draft';

  @override
  String get inspectionFormCompleting => 'Completing...';

  @override
  String get inspectionFormComplete => 'Complete inspection';

  @override
  String get inspectionFormDraftSaved => 'Draft saved successfully.';

  @override
  String get inspectionFormCompletedQueued =>
      'Inspection completed and queued for upload.';

  @override
  String inspectionFormPhotoSaved(String sizeKb) {
    return 'Photo saved ($sizeKb KB)';
  }

  @override
  String get inspectionFormCameraPermissionDenied =>
      'Camera permission denied. Enable it in app settings.';

  @override
  String inspectionFormNotesMinLength(int minLength) {
    return 'Minimum of $minLength characters.';
  }

  @override
  String get inspectionFormOpeningCamera => 'Opening camera...';

  @override
  String get inspectionFormCapturePhoto => 'Capture photo';

  @override
  String get inspectionFormRetakePhoto => 'Retake photo';

  @override
  String inspectionFormCompressedImage(String sizeKb) {
    return 'Compressed image — $sizeKb KB';
  }

  @override
  String get inspectionFormGettingLocation => 'Getting location...';

  @override
  String get inspectionFormCaptureGps => 'Capture GPS';

  @override
  String get inspectionFormUpdateGps => 'Update GPS';

  @override
  String get inspectionFormOpenSettings => 'Open settings';

  @override
  String inspectionFormLatitude(String value) {
    return 'Latitude: $value';
  }

  @override
  String inspectionFormLongitude(String value) {
    return 'Longitude: $value';
  }

  @override
  String inspectionFormAccuracy(String meters) {
    return 'Accuracy: $meters m';
  }

  @override
  String get inspectionConditionGood => 'Good';

  @override
  String get inspectionConditionRegular => 'Fair';

  @override
  String get inspectionConditionBad => 'Poor';

  @override
  String get inspectionConditionCritical => 'Critical';

  @override
  String geofenceWarning(int distance, int limit) {
    return 'You are $distance m from the work order point (limit: $limit m).';
  }

  @override
  String get validationNotesRequired => 'Observation is required.';

  @override
  String validationNotesMinLength(int minLength) {
    return 'Observation must be at least $minLength characters.';
  }

  @override
  String get validationPhotoRequired => 'Inspection photo is required.';

  @override
  String get validationLocationRequired => 'GPS location is required.';

  @override
  String get validationConditionRequired => 'Select the asset condition.';

  @override
  String get validationRequiredFields => 'Fill in all required fields.';

  @override
  String get validationFormNotLoaded => 'Inspection form is not loaded.';

  @override
  String get errorOpenInspection => 'Could not open this inspection.';

  @override
  String get errorLoadInspectionForm => 'Could not load the form.';

  @override
  String get errorLoadWorkOrder => 'Could not load the work order.';

  @override
  String get errorLocationPermissionDenied => 'Location permission denied.';

  @override
  String get errorLocationServiceDisabled =>
      'Enable the device location service.';

  @override
  String get errorLocationUnavailable => 'Could not obtain location.';

  @override
  String get errorNetworkGeneric =>
      'No internet connection. Check your network and try again.';

  @override
  String get syncNoInternet => 'No internet connection.';

  @override
  String get syncNothingPending => 'No pending inspections to sync.';

  @override
  String get syncSuccessOne => '1 inspection synced.';

  @override
  String syncSuccessMany(int count) {
    return '$count inspections synced.';
  }

  @override
  String get syncSomeFailed => 'Some inspections failed to sync.';

  @override
  String get syncRetryLater => 'Sync in progress. Try again in a moment.';
}
