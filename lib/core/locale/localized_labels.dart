import 'package:inspetorsys/features/inspections/domain/constants/inspection_geofence_constants.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_schema.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_condition.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';
import 'package:inspetorsys/features/sync/domain/entities/inspection_sync_result.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_priority.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';
import 'package:inspetorsys/l10n/app_localizations.dart';

extension WorkOrderStatusL10n on WorkOrderStatus {
  String localizedLabel(AppLocalizations l10n) => switch (this) {
        WorkOrderStatus.open => l10n.workOrderStatusOpen,
        WorkOrderStatus.inProgress => l10n.workOrderStatusInProgress,
        WorkOrderStatus.done => l10n.workOrderStatusDone,
      };
}

extension WorkOrderPriorityL10n on WorkOrderPriority {
  String localizedLabel(AppLocalizations l10n) => switch (this) {
        WorkOrderPriority.high => l10n.workOrderPriorityHigh,
        WorkOrderPriority.medium => l10n.workOrderPriorityMedium,
        WorkOrderPriority.low => l10n.workOrderPriorityLow,
      };
}

extension InspectionConditionL10n on InspectionCondition {
  String localizedLabel(AppLocalizations l10n) => switch (this) {
        InspectionCondition.bom => l10n.inspectionConditionGood,
        InspectionCondition.regular => l10n.inspectionConditionRegular,
        InspectionCondition.ruim => l10n.inspectionConditionBad,
        InspectionCondition.critico => l10n.inspectionConditionCritical,
      };
}

extension InspectionSyncStatusL10n on InspectionSyncStatus {
  String localizedLabel(AppLocalizations l10n) => switch (this) {
        InspectionSyncStatus.draft => l10n.syncStatusDraft,
        InspectionSyncStatus.pending => l10n.syncStatusPending,
        InspectionSyncStatus.synced => l10n.syncStatusSynced,
        InspectionSyncStatus.failed => l10n.syncStatusFailed,
      };
}

String localizedInspectionFormFieldLabel(
  AppLocalizations l10n,
  InspectionFormFieldSchema field,
) {
  return switch (field.key) {
    'observation' => l10n.inspectionFormFieldObservation,
    'condition' => l10n.inspectionFormFieldCondition,
    'photo' => l10n.inspectionFormFieldPhoto,
    'location' => l10n.inspectionFormFieldLocation,
    _ => field.label,
  };
}

String localizedGeofenceWarning(
  AppLocalizations l10n, {
  required double distanceMeters,
}) {
  return l10n.geofenceWarning(
    distanceMeters.round(),
    InspectionGeofenceConstants.warningRadiusMeters.round(),
  );
}

String localizedSyncFeedback(
  AppLocalizations l10n,
  InspectionSyncResult result,
) {
  if (result.processed == 0) {
    return l10n.syncNothingPending;
  }

  if (result.synced > 0) {
    return result.synced == 1
        ? l10n.syncSuccessOne
        : l10n.syncSuccessMany(result.synced);
  }

  if (result.markedFailed > 0) {
    return l10n.syncSomeFailed;
  }

  return l10n.syncRetryLater;
}

String? localizeValidationMessage(AppLocalizations l10n, String? message) {
  if (message == null || message.isEmpty) {
    return message;
  }

  final minLengthMatch = RegExp(
    r'^A observação deve ter no mínimo (\d+) caracteres\.$',
  ).firstMatch(message);
  if (minLengthMatch != null) {
    final minLength = int.parse(minLengthMatch.group(1)!);
    return l10n.validationNotesMinLength(minLength);
  }

  return switch (message) {
    'A observação é obrigatória.' => l10n.validationNotesRequired,
    'A foto da inspeção é obrigatória.' => l10n.validationPhotoRequired,
    'A localização GPS é obrigatória.' => l10n.validationLocationRequired,
    'Selecione a condição do ativo.' => l10n.validationConditionRequired,
    'Preencha todos os campos obrigatórios.' => l10n.validationRequiredFields,
    'Formulário da inspeção não carregado.' => l10n.validationFormNotLoaded,
    'Não foi possível abrir esta inspeção.' => l10n.errorOpenInspection,
    'Não foi possível carregar o formulário.' => l10n.errorLoadInspectionForm,
    'Não foi possível carregar a ordem de serviço.' => l10n.errorLoadWorkOrder,
    'Permissão de localização negada.' => l10n.errorLocationPermissionDenied,
    'Ative o serviço de localização do dispositivo.' =>
      l10n.errorLocationServiceDisabled,
    'Não foi possível obter a localização.' => l10n.errorLocationUnavailable,
    'Sem conexão com a internet. Verifique sua rede e tente novamente.' =>
      l10n.errorNetworkGeneric,
    'E-mail ou senha inválidos.' => l10n.loginInvalidCredentials,
    'Sem conexão com a internet.' => l10n.syncNoInternet,
    'Nenhuma inspeção pendente para sincronizar.' => l10n.syncNothingPending,
    'Algumas inspeções falharam ao sincronizar.' => l10n.syncSomeFailed,
    'Sincronização em andamento. Tente novamente em instantes.' =>
      l10n.syncRetryLater,
    'Inspeção reenviada para sincronização.' => l10n.inspectionRetryQueued,
    'Não foi possível reenviar a inspeção.' => l10n.inspectionRetryFailed,
    _ => _localizeDynamicSyncMessage(l10n, message) ?? message,
  };
}

String? _localizeDynamicSyncMessage(AppLocalizations l10n, String message) {
  final oneSynced = RegExp(r'^1 inspeção sincronizada\.$').hasMatch(message);
  if (oneSynced) {
    return l10n.syncSuccessOne;
  }

  final manySynced = RegExp(r'^(\d+) inspeções sincronizadas\.$').firstMatch(message);
  if (manySynced != null) {
    return l10n.syncSuccessMany(int.parse(manySynced.group(1)!));
  }

  return null;
}

String localizeFailureMessage(AppLocalizations l10n, String message) {
  return localizeValidationMessage(l10n, message) ?? message;
}
