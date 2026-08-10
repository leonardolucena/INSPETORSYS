// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'InspetorSYS';

  @override
  String get appSlogan => 'SISTEMA DE INSPEÇÃO DE CAMPO';

  @override
  String get drawerWorkOrders => 'Ordens de serviço';

  @override
  String get drawerInspectionsHistory => 'Histórico de inspeções';

  @override
  String get drawerSyncInspections => 'Sincronizar inspeções';

  @override
  String get drawerLanguage => 'Idioma';

  @override
  String get drawerHighContrast => 'Alto contraste';

  @override
  String get drawerDarkMode => 'Modo escuro';

  @override
  String get languagePortuguese => 'Português';

  @override
  String get languageEnglish => 'English';

  @override
  String get userFallback => 'Usuário';

  @override
  String get connectionOnline => 'Online';

  @override
  String get connectionNoInternet => 'Sem internet';

  @override
  String get connectionOffline => 'Offline';

  @override
  String get loginEmailLabel => 'E-mail';

  @override
  String get loginPasswordLabel => 'Senha';

  @override
  String get loginSubmitting => 'ENTRANDO...';

  @override
  String get loginSubmit => 'ENTRAR';

  @override
  String get loginInvalidCredentials => 'E-mail ou senha inválidos.';

  @override
  String get workOrdersTitle => 'Ordens de serviço';

  @override
  String get workOrdersLoadError =>
      'Não foi possível carregar as ordens de serviço.';

  @override
  String get workOrdersEmptyTitle => 'Nenhuma ordem de serviço';

  @override
  String get workOrdersEmptyMessageAll =>
      'Não há ordens de serviço disponíveis no momento.';

  @override
  String get workOrdersEmptyMessageFiltered =>
      'Nenhuma ordem com o filtro selecionado.';

  @override
  String get workOrdersEmptyMessageSearch =>
      'Nenhuma ordem de serviço com este código.';

  @override
  String get searchByWorkOrderCodePlaceholder => 'Buscar por código da OS';

  @override
  String get refreshAction => 'Atualizar';

  @override
  String get retryAction => 'Tentar novamente';

  @override
  String get filterAll => 'Todas';

  @override
  String get workOrderStatusOpen => 'Aberta';

  @override
  String get workOrderStatusInProgress => 'Em andamento';

  @override
  String get workOrderStatusDone => 'Concluída';

  @override
  String get workOrderPriorityHigh => 'Alta';

  @override
  String get workOrderPriorityMedium => 'Média';

  @override
  String get workOrderPriorityLow => 'Baixa';

  @override
  String get workOrderDetailTitle => 'Detalhe da OS';

  @override
  String get workOrderDetailLoadError =>
      'Não foi possível carregar a ordem de serviço.';

  @override
  String get workOrderDescriptionLabel => 'Descrição:';

  @override
  String get workOrderAddressLabel => 'Endereço:';

  @override
  String get workOrderNotesLabel => 'Anotações:';

  @override
  String get workOrderScheduledForLabel => 'Agendada para';

  @override
  String get workOrderUpdatedAtLabel => 'Atualizada em';

  @override
  String get workOrderLocationTitle => 'Localização';

  @override
  String get workOrderNewInspection => 'Nova inspeção';

  @override
  String get inspectionsHistoryTitle => 'Histórico de inspeções';

  @override
  String get inspectionsLoadError =>
      'Não foi possível carregar as inspeções locais.';

  @override
  String get inspectionsEmptyTitle => 'Nenhuma inspeção encontrada';

  @override
  String get inspectionsEmptyMessageAll =>
      'Você ainda não registrou inspeções neste dispositivo.';

  @override
  String get inspectionsEmptyMessageFiltered =>
      'Nenhuma inspeção com o status selecionado.';

  @override
  String get inspectionsEmptyMessageSearch =>
      'Nenhuma inspeção com este código de OS.';

  @override
  String get inspectionNotEditable =>
      'Esta inspeção já foi concluída e não pode ser editada.';

  @override
  String get inspectionDetailTitle => 'Detalhes da inspeção';

  @override
  String get inspectionDetailLoadError =>
      'Não foi possível carregar os detalhes da inspeção.';

  @override
  String get inspectionDetailCreatedAtLabel => 'Criada em';

  @override
  String get inspectionDetailUpdatedAtLabel => 'Atualizada em';

  @override
  String get inspectionDetailSyncedAtLabel => 'Enviada em';

  @override
  String get inspectionDetailEmptyValue => '—';

  @override
  String get inspectionRetryQueued => 'Inspeção reenviada para sincronização.';

  @override
  String get inspectionRetryFailed => 'Não foi possível reenviar a inspeção.';

  @override
  String get syncStatusDraft => 'Rascunho';

  @override
  String get syncStatusPending => 'Pendente';

  @override
  String get syncStatusSynced => 'Enviado';

  @override
  String get syncStatusFailed => 'Falhou';

  @override
  String get inspectionRemoteSyncSynced => 'Sincronizado';

  @override
  String get inspectionRemoteSyncNotSynced => 'Não sincronizado';

  @override
  String get inspectionFormNewTitle => 'Nova inspeção';

  @override
  String get inspectionFormContinueTitle => 'Continuar inspeção';

  @override
  String get inspectionFormLoadError =>
      'Não foi possível carregar o formulário da inspeção.';

  @override
  String get inspectionFormFieldObservation => 'Observação';

  @override
  String get inspectionFormFieldCondition => 'Condição do ativo';

  @override
  String get inspectionFormFieldPhoto => 'Foto da evidência';

  @override
  String get inspectionFormFieldLocation => 'Local da inspeção';

  @override
  String get inspectionFormSavingDraft => 'Salvando...';

  @override
  String get inspectionFormSaveDraft => 'Salvar rascunho';

  @override
  String get inspectionFormCompleting => 'Concluindo...';

  @override
  String get inspectionFormComplete => 'Concluir inspeção';

  @override
  String get inspectionFormDraftSaved => 'Rascunho salvo com sucesso.';

  @override
  String get inspectionFormCompletedQueued =>
      'Inspeção concluída e enfileirada para envio.';

  @override
  String inspectionFormPhotoSaved(String sizeKb) {
    return 'Foto salva ($sizeKb KB)';
  }

  @override
  String get inspectionFormCameraPermissionDenied =>
      'Permissão de câmera negada. Habilite nas configurações do app.';

  @override
  String inspectionFormNotesMinLength(int minLength) {
    return 'Mínimo de $minLength caracteres.';
  }

  @override
  String get inspectionFormOpeningCamera => 'Abrindo câmera...';

  @override
  String get inspectionFormCapturePhoto => 'Capturar foto';

  @override
  String get inspectionFormRetakePhoto => 'Tirar nova foto';

  @override
  String inspectionFormCompressedImage(String sizeKb) {
    return 'Imagem comprimida — $sizeKb KB';
  }

  @override
  String get inspectionFormGettingLocation => 'Obtendo localização...';

  @override
  String get inspectionFormCaptureGps => 'Capturar GPS';

  @override
  String get inspectionFormUpdateGps => 'Atualizar GPS';

  @override
  String get inspectionFormOpenSettings => 'Abrir configurações';

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
    return 'Precisão: $meters m';
  }

  @override
  String get inspectionConditionGood => 'Bom';

  @override
  String get inspectionConditionRegular => 'Regular';

  @override
  String get inspectionConditionBad => 'Ruim';

  @override
  String get inspectionConditionCritical => 'Crítico';

  @override
  String geofenceWarning(int distance, int limit) {
    return 'Você está a $distance m do ponto da OS (limite: $limit m).';
  }

  @override
  String get validationNotesRequired => 'A observação é obrigatória.';

  @override
  String validationNotesMinLength(int minLength) {
    return 'A observação deve ter no mínimo $minLength caracteres.';
  }

  @override
  String get validationPhotoRequired => 'A foto da inspeção é obrigatória.';

  @override
  String get validationLocationRequired => 'A localização GPS é obrigatória.';

  @override
  String get validationConditionRequired => 'Selecione a condição do ativo.';

  @override
  String get validationRequiredFields =>
      'Preencha todos os campos obrigatórios.';

  @override
  String get validationFormNotLoaded => 'Formulário da inspeção não carregado.';

  @override
  String get errorOpenInspection => 'Não foi possível abrir esta inspeção.';

  @override
  String get errorLoadInspectionForm =>
      'Não foi possível carregar o formulário.';

  @override
  String get errorLoadWorkOrder =>
      'Não foi possível carregar a ordem de serviço.';

  @override
  String get errorLocationPermissionDenied =>
      'Permissão de localização negada.';

  @override
  String get errorLocationServiceDisabled =>
      'Ative o serviço de localização do dispositivo.';

  @override
  String get errorLocationUnavailable =>
      'Não foi possível obter a localização.';

  @override
  String get errorNetworkGeneric =>
      'Sem conexão com a internet. Verifique sua rede e tente novamente.';

  @override
  String get syncNoInternet => 'Sem conexão com a internet.';

  @override
  String get syncNothingPending =>
      'Nenhuma inspeção pendente para sincronizar.';

  @override
  String get syncSuccessOne => '1 inspeção sincronizada.';

  @override
  String syncSuccessMany(int count) {
    return '$count inspeções sincronizadas.';
  }

  @override
  String get syncSomeFailed => 'Algumas inspeções falharam ao sincronizar.';

  @override
  String get syncRetryLater =>
      'Sincronização em andamento. Tente novamente em instantes.';
}
