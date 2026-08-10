import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In pt, this message translates to:
  /// **'InspetorSYS'**
  String get appTitle;

  /// No description provided for @appSlogan.
  ///
  /// In pt, this message translates to:
  /// **'SISTEMA DE INSPEÇÃO DE CAMPO'**
  String get appSlogan;

  /// No description provided for @drawerWorkOrders.
  ///
  /// In pt, this message translates to:
  /// **'Ordens de serviço'**
  String get drawerWorkOrders;

  /// No description provided for @drawerInspectionsHistory.
  ///
  /// In pt, this message translates to:
  /// **'Histórico de inspeções'**
  String get drawerInspectionsHistory;

  /// No description provided for @drawerSyncInspections.
  ///
  /// In pt, this message translates to:
  /// **'Sincronizar inspeções'**
  String get drawerSyncInspections;

  /// No description provided for @drawerLanguage.
  ///
  /// In pt, this message translates to:
  /// **'Idioma'**
  String get drawerLanguage;

  /// No description provided for @drawerHighContrast.
  ///
  /// In pt, this message translates to:
  /// **'Alto contraste'**
  String get drawerHighContrast;

  /// No description provided for @drawerDarkMode.
  ///
  /// In pt, this message translates to:
  /// **'Modo escuro'**
  String get drawerDarkMode;

  /// No description provided for @languagePortuguese.
  ///
  /// In pt, this message translates to:
  /// **'Português'**
  String get languagePortuguese;

  /// No description provided for @languageEnglish.
  ///
  /// In pt, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @userFallback.
  ///
  /// In pt, this message translates to:
  /// **'Usuário'**
  String get userFallback;

  /// No description provided for @connectionOnline.
  ///
  /// In pt, this message translates to:
  /// **'Online'**
  String get connectionOnline;

  /// No description provided for @connectionNoInternet.
  ///
  /// In pt, this message translates to:
  /// **'Sem internet'**
  String get connectionNoInternet;

  /// No description provided for @connectionOffline.
  ///
  /// In pt, this message translates to:
  /// **'Offline'**
  String get connectionOffline;

  /// No description provided for @loginEmailLabel.
  ///
  /// In pt, this message translates to:
  /// **'E-mail'**
  String get loginEmailLabel;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get loginPasswordLabel;

  /// No description provided for @loginSubmitting.
  ///
  /// In pt, this message translates to:
  /// **'ENTRANDO...'**
  String get loginSubmitting;

  /// No description provided for @loginSubmit.
  ///
  /// In pt, this message translates to:
  /// **'ENTRAR'**
  String get loginSubmit;

  /// No description provided for @loginInvalidCredentials.
  ///
  /// In pt, this message translates to:
  /// **'E-mail ou senha inválidos.'**
  String get loginInvalidCredentials;

  /// No description provided for @workOrdersTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ordens de serviço'**
  String get workOrdersTitle;

  /// No description provided for @workOrdersLoadError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível carregar as ordens de serviço.'**
  String get workOrdersLoadError;

  /// No description provided for @workOrdersEmptyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma ordem de serviço'**
  String get workOrdersEmptyTitle;

  /// No description provided for @workOrdersEmptyMessageAll.
  ///
  /// In pt, this message translates to:
  /// **'Não há ordens de serviço disponíveis no momento.'**
  String get workOrdersEmptyMessageAll;

  /// No description provided for @workOrdersEmptyMessageFiltered.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma ordem com o filtro selecionado.'**
  String get workOrdersEmptyMessageFiltered;

  /// No description provided for @workOrdersEmptyMessageSearch.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma ordem de serviço com este código.'**
  String get workOrdersEmptyMessageSearch;

  /// No description provided for @searchByWorkOrderCodePlaceholder.
  ///
  /// In pt, this message translates to:
  /// **'Buscar por código da OS'**
  String get searchByWorkOrderCodePlaceholder;

  /// No description provided for @refreshAction.
  ///
  /// In pt, this message translates to:
  /// **'Atualizar'**
  String get refreshAction;

  /// No description provided for @retryAction.
  ///
  /// In pt, this message translates to:
  /// **'Tentar novamente'**
  String get retryAction;

  /// No description provided for @filterAll.
  ///
  /// In pt, this message translates to:
  /// **'Todas'**
  String get filterAll;

  /// No description provided for @workOrderStatusOpen.
  ///
  /// In pt, this message translates to:
  /// **'Aberta'**
  String get workOrderStatusOpen;

  /// No description provided for @workOrderStatusInProgress.
  ///
  /// In pt, this message translates to:
  /// **'Em andamento'**
  String get workOrderStatusInProgress;

  /// No description provided for @workOrderStatusDone.
  ///
  /// In pt, this message translates to:
  /// **'Concluída'**
  String get workOrderStatusDone;

  /// No description provided for @workOrderPriorityHigh.
  ///
  /// In pt, this message translates to:
  /// **'Alta'**
  String get workOrderPriorityHigh;

  /// No description provided for @workOrderPriorityMedium.
  ///
  /// In pt, this message translates to:
  /// **'Média'**
  String get workOrderPriorityMedium;

  /// No description provided for @workOrderPriorityLow.
  ///
  /// In pt, this message translates to:
  /// **'Baixa'**
  String get workOrderPriorityLow;

  /// No description provided for @workOrderDetailTitle.
  ///
  /// In pt, this message translates to:
  /// **'Detalhe da OS'**
  String get workOrderDetailTitle;

  /// No description provided for @workOrderDetailLoadError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível carregar a ordem de serviço.'**
  String get workOrderDetailLoadError;

  /// No description provided for @workOrderDescriptionLabel.
  ///
  /// In pt, this message translates to:
  /// **'Descrição:'**
  String get workOrderDescriptionLabel;

  /// No description provided for @workOrderAddressLabel.
  ///
  /// In pt, this message translates to:
  /// **'Endereço:'**
  String get workOrderAddressLabel;

  /// No description provided for @workOrderNotesLabel.
  ///
  /// In pt, this message translates to:
  /// **'Anotações:'**
  String get workOrderNotesLabel;

  /// No description provided for @workOrderScheduledForLabel.
  ///
  /// In pt, this message translates to:
  /// **'Agendada para'**
  String get workOrderScheduledForLabel;

  /// No description provided for @workOrderUpdatedAtLabel.
  ///
  /// In pt, this message translates to:
  /// **'Atualizada em'**
  String get workOrderUpdatedAtLabel;

  /// No description provided for @workOrderLocationTitle.
  ///
  /// In pt, this message translates to:
  /// **'Localização'**
  String get workOrderLocationTitle;

  /// No description provided for @workOrderNewInspection.
  ///
  /// In pt, this message translates to:
  /// **'Nova inspeção'**
  String get workOrderNewInspection;

  /// No description provided for @inspectionsHistoryTitle.
  ///
  /// In pt, this message translates to:
  /// **'Histórico de inspeções'**
  String get inspectionsHistoryTitle;

  /// No description provided for @inspectionsLoadError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível carregar as inspeções locais.'**
  String get inspectionsLoadError;

  /// No description provided for @inspectionsEmptyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma inspeção encontrada'**
  String get inspectionsEmptyTitle;

  /// No description provided for @inspectionsEmptyMessageAll.
  ///
  /// In pt, this message translates to:
  /// **'Você ainda não registrou inspeções neste dispositivo.'**
  String get inspectionsEmptyMessageAll;

  /// No description provided for @inspectionsEmptyMessageFiltered.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma inspeção com o status selecionado.'**
  String get inspectionsEmptyMessageFiltered;

  /// No description provided for @inspectionsEmptyMessageSearch.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma inspeção com este código de OS.'**
  String get inspectionsEmptyMessageSearch;

  /// No description provided for @inspectionNotEditable.
  ///
  /// In pt, this message translates to:
  /// **'Esta inspeção já foi concluída e não pode ser editada.'**
  String get inspectionNotEditable;

  /// No description provided for @inspectionDetailTitle.
  ///
  /// In pt, this message translates to:
  /// **'Detalhes da inspeção'**
  String get inspectionDetailTitle;

  /// No description provided for @inspectionDetailLoadError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível carregar os detalhes da inspeção.'**
  String get inspectionDetailLoadError;

  /// No description provided for @inspectionDetailCreatedAtLabel.
  ///
  /// In pt, this message translates to:
  /// **'Criada em'**
  String get inspectionDetailCreatedAtLabel;

  /// No description provided for @inspectionDetailUpdatedAtLabel.
  ///
  /// In pt, this message translates to:
  /// **'Atualizada em'**
  String get inspectionDetailUpdatedAtLabel;

  /// No description provided for @inspectionDetailSyncedAtLabel.
  ///
  /// In pt, this message translates to:
  /// **'Enviada em'**
  String get inspectionDetailSyncedAtLabel;

  /// No description provided for @inspectionDetailEmptyValue.
  ///
  /// In pt, this message translates to:
  /// **'—'**
  String get inspectionDetailEmptyValue;

  /// No description provided for @inspectionRetryQueued.
  ///
  /// In pt, this message translates to:
  /// **'Inspeção reenviada para sincronização.'**
  String get inspectionRetryQueued;

  /// No description provided for @inspectionRetryFailed.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível reenviar a inspeção.'**
  String get inspectionRetryFailed;

  /// No description provided for @syncStatusDraft.
  ///
  /// In pt, this message translates to:
  /// **'Rascunho'**
  String get syncStatusDraft;

  /// No description provided for @syncStatusPending.
  ///
  /// In pt, this message translates to:
  /// **'Pendente'**
  String get syncStatusPending;

  /// No description provided for @syncStatusSynced.
  ///
  /// In pt, this message translates to:
  /// **'Enviado'**
  String get syncStatusSynced;

  /// No description provided for @syncStatusFailed.
  ///
  /// In pt, this message translates to:
  /// **'Falhou'**
  String get syncStatusFailed;

  /// No description provided for @inspectionRemoteSyncSynced.
  ///
  /// In pt, this message translates to:
  /// **'Sincronizado'**
  String get inspectionRemoteSyncSynced;

  /// No description provided for @inspectionRemoteSyncNotSynced.
  ///
  /// In pt, this message translates to:
  /// **'Não sincronizado'**
  String get inspectionRemoteSyncNotSynced;

  /// No description provided for @inspectionFormNewTitle.
  ///
  /// In pt, this message translates to:
  /// **'Nova inspeção'**
  String get inspectionFormNewTitle;

  /// No description provided for @inspectionFormContinueTitle.
  ///
  /// In pt, this message translates to:
  /// **'Continuar inspeção'**
  String get inspectionFormContinueTitle;

  /// No description provided for @inspectionFormLoadError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível carregar o formulário da inspeção.'**
  String get inspectionFormLoadError;

  /// No description provided for @inspectionFormFieldObservation.
  ///
  /// In pt, this message translates to:
  /// **'Observação'**
  String get inspectionFormFieldObservation;

  /// No description provided for @inspectionFormFieldCondition.
  ///
  /// In pt, this message translates to:
  /// **'Condição do ativo'**
  String get inspectionFormFieldCondition;

  /// No description provided for @inspectionFormFieldPhoto.
  ///
  /// In pt, this message translates to:
  /// **'Foto da evidência'**
  String get inspectionFormFieldPhoto;

  /// No description provided for @inspectionFormFieldLocation.
  ///
  /// In pt, this message translates to:
  /// **'Local da inspeção'**
  String get inspectionFormFieldLocation;

  /// No description provided for @inspectionFormSavingDraft.
  ///
  /// In pt, this message translates to:
  /// **'Salvando...'**
  String get inspectionFormSavingDraft;

  /// No description provided for @inspectionFormSaveDraft.
  ///
  /// In pt, this message translates to:
  /// **'Salvar rascunho'**
  String get inspectionFormSaveDraft;

  /// No description provided for @inspectionFormCompleting.
  ///
  /// In pt, this message translates to:
  /// **'Concluindo...'**
  String get inspectionFormCompleting;

  /// No description provided for @inspectionFormComplete.
  ///
  /// In pt, this message translates to:
  /// **'Concluir inspeção'**
  String get inspectionFormComplete;

  /// No description provided for @inspectionFormDraftSaved.
  ///
  /// In pt, this message translates to:
  /// **'Rascunho salvo com sucesso.'**
  String get inspectionFormDraftSaved;

  /// No description provided for @inspectionFormCompletedQueued.
  ///
  /// In pt, this message translates to:
  /// **'Inspeção concluída e enfileirada para envio.'**
  String get inspectionFormCompletedQueued;

  /// No description provided for @inspectionFormPhotoSaved.
  ///
  /// In pt, this message translates to:
  /// **'Foto salva ({sizeKb} KB)'**
  String inspectionFormPhotoSaved(String sizeKb);

  /// No description provided for @inspectionFormCameraPermissionDenied.
  ///
  /// In pt, this message translates to:
  /// **'Permissão de câmera negada. Habilite nas configurações do app.'**
  String get inspectionFormCameraPermissionDenied;

  /// No description provided for @inspectionFormNotesMinLength.
  ///
  /// In pt, this message translates to:
  /// **'Mínimo de {minLength} caracteres.'**
  String inspectionFormNotesMinLength(int minLength);

  /// No description provided for @inspectionFormOpeningCamera.
  ///
  /// In pt, this message translates to:
  /// **'Abrindo câmera...'**
  String get inspectionFormOpeningCamera;

  /// No description provided for @inspectionFormCapturePhoto.
  ///
  /// In pt, this message translates to:
  /// **'Capturar foto'**
  String get inspectionFormCapturePhoto;

  /// No description provided for @inspectionFormRetakePhoto.
  ///
  /// In pt, this message translates to:
  /// **'Tirar nova foto'**
  String get inspectionFormRetakePhoto;

  /// No description provided for @inspectionFormCompressedImage.
  ///
  /// In pt, this message translates to:
  /// **'Imagem comprimida — {sizeKb} KB'**
  String inspectionFormCompressedImage(String sizeKb);

  /// No description provided for @inspectionFormGettingLocation.
  ///
  /// In pt, this message translates to:
  /// **'Obtendo localização...'**
  String get inspectionFormGettingLocation;

  /// No description provided for @inspectionFormCaptureGps.
  ///
  /// In pt, this message translates to:
  /// **'Capturar GPS'**
  String get inspectionFormCaptureGps;

  /// No description provided for @inspectionFormUpdateGps.
  ///
  /// In pt, this message translates to:
  /// **'Atualizar GPS'**
  String get inspectionFormUpdateGps;

  /// No description provided for @inspectionFormOpenSettings.
  ///
  /// In pt, this message translates to:
  /// **'Abrir configurações'**
  String get inspectionFormOpenSettings;

  /// No description provided for @inspectionFormLatitude.
  ///
  /// In pt, this message translates to:
  /// **'Latitude: {value}'**
  String inspectionFormLatitude(String value);

  /// No description provided for @inspectionFormLongitude.
  ///
  /// In pt, this message translates to:
  /// **'Longitude: {value}'**
  String inspectionFormLongitude(String value);

  /// No description provided for @inspectionFormAccuracy.
  ///
  /// In pt, this message translates to:
  /// **'Precisão: {meters} m'**
  String inspectionFormAccuracy(String meters);

  /// No description provided for @inspectionConditionGood.
  ///
  /// In pt, this message translates to:
  /// **'Bom'**
  String get inspectionConditionGood;

  /// No description provided for @inspectionConditionRegular.
  ///
  /// In pt, this message translates to:
  /// **'Regular'**
  String get inspectionConditionRegular;

  /// No description provided for @inspectionConditionBad.
  ///
  /// In pt, this message translates to:
  /// **'Ruim'**
  String get inspectionConditionBad;

  /// No description provided for @inspectionConditionCritical.
  ///
  /// In pt, this message translates to:
  /// **'Crítico'**
  String get inspectionConditionCritical;

  /// No description provided for @geofenceWarning.
  ///
  /// In pt, this message translates to:
  /// **'Você está a {distance} m do ponto da OS (limite: {limit} m).'**
  String geofenceWarning(int distance, int limit);

  /// No description provided for @validationNotesRequired.
  ///
  /// In pt, this message translates to:
  /// **'A observação é obrigatória.'**
  String get validationNotesRequired;

  /// No description provided for @validationNotesMinLength.
  ///
  /// In pt, this message translates to:
  /// **'A observação deve ter no mínimo {minLength} caracteres.'**
  String validationNotesMinLength(int minLength);

  /// No description provided for @validationPhotoRequired.
  ///
  /// In pt, this message translates to:
  /// **'A foto da inspeção é obrigatória.'**
  String get validationPhotoRequired;

  /// No description provided for @validationLocationRequired.
  ///
  /// In pt, this message translates to:
  /// **'A localização GPS é obrigatória.'**
  String get validationLocationRequired;

  /// No description provided for @validationConditionRequired.
  ///
  /// In pt, this message translates to:
  /// **'Selecione a condição do ativo.'**
  String get validationConditionRequired;

  /// No description provided for @validationRequiredFields.
  ///
  /// In pt, this message translates to:
  /// **'Preencha todos os campos obrigatórios.'**
  String get validationRequiredFields;

  /// No description provided for @validationFormNotLoaded.
  ///
  /// In pt, this message translates to:
  /// **'Formulário da inspeção não carregado.'**
  String get validationFormNotLoaded;

  /// No description provided for @errorOpenInspection.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível abrir esta inspeção.'**
  String get errorOpenInspection;

  /// No description provided for @errorLoadInspectionForm.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível carregar o formulário.'**
  String get errorLoadInspectionForm;

  /// No description provided for @errorLoadWorkOrder.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível carregar a ordem de serviço.'**
  String get errorLoadWorkOrder;

  /// No description provided for @errorLocationPermissionDenied.
  ///
  /// In pt, this message translates to:
  /// **'Permissão de localização negada.'**
  String get errorLocationPermissionDenied;

  /// No description provided for @errorLocationServiceDisabled.
  ///
  /// In pt, this message translates to:
  /// **'Ative o serviço de localização do dispositivo.'**
  String get errorLocationServiceDisabled;

  /// No description provided for @errorLocationUnavailable.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível obter a localização.'**
  String get errorLocationUnavailable;

  /// No description provided for @errorNetworkGeneric.
  ///
  /// In pt, this message translates to:
  /// **'Sem conexão com a internet. Verifique sua rede e tente novamente.'**
  String get errorNetworkGeneric;

  /// No description provided for @syncNoInternet.
  ///
  /// In pt, this message translates to:
  /// **'Sem conexão com a internet.'**
  String get syncNoInternet;

  /// No description provided for @syncNothingPending.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma inspeção pendente para sincronizar.'**
  String get syncNothingPending;

  /// No description provided for @syncSuccessOne.
  ///
  /// In pt, this message translates to:
  /// **'1 inspeção sincronizada.'**
  String get syncSuccessOne;

  /// No description provided for @syncSuccessMany.
  ///
  /// In pt, this message translates to:
  /// **'{count} inspeções sincronizadas.'**
  String syncSuccessMany(int count);

  /// No description provided for @syncSomeFailed.
  ///
  /// In pt, this message translates to:
  /// **'Algumas inspeções falharam ao sincronizar.'**
  String get syncSomeFailed;

  /// No description provided for @syncRetryLater.
  ///
  /// In pt, this message translates to:
  /// **'Sincronização em andamento. Tente novamente em instantes.'**
  String get syncRetryLater;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
