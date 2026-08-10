import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inspetorsys/components/app_drawer_app_bar_leading.dart';
import 'package:inspetorsys/components/elevated_button.dart';
import 'package:inspetorsys/components/outline_button.dart';
import 'package:inspetorsys/components/states/app_error_state.dart';
import 'package:inspetorsys/core/feedback/app_snackbar.dart';
import 'package:inspetorsys/core/image/image_exception.dart';
import 'package:inspetorsys/core/locale/l10n_extensions.dart';
import 'package:inspetorsys/core/locale/localized_labels.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/features/inspections/domain/constants/inspection_geofence_constants.dart';
import 'package:inspetorsys/features/inspections/presentation/cubit/inspection_form_cubit.dart';
import 'package:inspetorsys/features/inspections/presentation/cubit/inspection_form_state.dart';
import 'package:inspetorsys/features/inspections/presentation/widgets/inspection_dynamic_form_fields.dart';
import 'package:inspetorsys/components/states/screen_loading_shimmers.dart';
import 'package:inspetorsys/features/sync/presentation/cubit/sync_cubit.dart';
import 'package:inspetorsys/features/work_orders/presentation/widgets/work_orders_drawer.dart';
import 'package:inspetorsys/theme/app_colors.dart';

class InspectionFormPage extends StatefulWidget {
  const InspectionFormPage({
    super.key,
    required this.workOrderId,
    this.workOrderCode,
  });

  final String workOrderId;
  final String? workOrderCode;

  @override
  State<InspectionFormPage> createState() => _InspectionFormPageState();
}

class _InspectionFormPageState extends State<InspectionFormPage> {
  late final TextEditingController _notesController;
  late final FocusNode _notesFocusNode;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
    _notesFocusNode = FocusNode()..addListener(_handleNotesFocusChange);
    context.read<InspectionFormCubit>().load();
  }

  @override
  void dispose() {
    _notesFocusNode.removeListener(_handleNotesFocusChange);
    _notesFocusNode.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _handleNotesFocusChange() {
    if (!_notesFocusNode.hasFocus) {
      context.read<InspectionFormCubit>().validateNotesField();
    }
  }

  Future<void> _handleCapturePhoto() async {
    try {
      await context.read<InspectionFormCubit>().capturePhoto();

      if (!mounted) {
        return;
      }

      final state = context.read<InspectionFormCubit>().state;
      if (state.photoPath != null && state.photoSizeBytes != null) {
        AppSnackbar.success(
          context,
          context.l10n.inspectionFormPhotoSaved(
            (state.photoSizeBytes! / 1024).toStringAsFixed(0),
          ),
        );
      }
    } on ImagePermissionDeniedException {
      if (!mounted) {
        return;
      }

      AppSnackbar.error(
        context,
        context.l10n.inspectionFormCameraPermissionDenied,
      );
    } on ImageException catch (error) {
      if (!mounted) {
        return;
      }

      AppSnackbar.error(
        context,
        localizeFailureMessage(context.l10n, error.message),
      );
    }
  }

  Future<void> _handleCaptureLocation() async {
    await context.read<InspectionFormCubit>().captureLocation();

    if (!mounted) {
      return;
    }

    final state = context.read<InspectionFormCubit>().state;
    final distance = state.distanceFromWorkOrderMeters;
    if (distance != null &&
        distance > InspectionGeofenceConstants.warningRadiusMeters) {
      AppSnackbar.info(
        context,
        localizedGeofenceWarning(
          context.l10n,
          distanceMeters: distance,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InspectionFormCubit, InspectionFormState>(
      listenWhen: (previous, current) =>
          previous.saveStatus != current.saveStatus ||
          (previous.loadStatus != InspectionFormLoadStatus.success &&
              current.loadStatus == InspectionFormLoadStatus.success),
      listener: (context, state) {
        if (state.loadStatus == InspectionFormLoadStatus.success &&
            _notesController.text != state.notes) {
          _notesController.text = state.notes;
        }

        switch (state.saveStatus) {
          case InspectionFormSaveStatus.draftSaved:
            AppSnackbar.success(context, context.l10n.inspectionFormDraftSaved);
            context.pop();
          case InspectionFormSaveStatus.completed:
            AppSnackbar.success(
              context,
              context.l10n.inspectionFormCompletedQueued,
            );
            unawaited(context.read<SyncCubit>().refreshPendingCount());
            context.pop();
          case InspectionFormSaveStatus.failure:
            if (state.saveErrorMessage != null) {
              AppSnackbar.error(
                context,
                localizeFailureMessage(
                  context.l10n,
                  state.saveErrorMessage!,
                ),
              );
            }
            context.read<InspectionFormCubit>().resetSaveStatus();
          case InspectionFormSaveStatus.idle:
          case InspectionFormSaveStatus.saving:
            break;
        }
      },
      builder: (context, state) {
        final l10n = context.l10n;
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final screenBackgroundColor = isDark
            ? AppColors.backgroundCardDark
            : AppColors.listScreenBackgroundLight;

        return Scaffold(
          backgroundColor: screenBackgroundColor,
          drawer: const WorkOrdersDrawer(),
          appBar: AppDrawerAppBar(
            title: state.clientId == null
                ? l10n.inspectionFormNewTitle
                : l10n.inspectionFormContinueTitle,
            backgroundColor: screenBackgroundColor,
          ),
          body: switch (state.loadStatus) {
            InspectionFormLoadStatus.initial ||
            InspectionFormLoadStatus.loading =>
              Padding(
                padding: EdgeInsets.all(AppSizes.cardPadding),
                child: const InspectionFormShimmer(),
              ),
            InspectionFormLoadStatus.failure => Padding(
                padding: EdgeInsets.all(AppSizes.cardPadding),
                child: AppErrorState(
                  message: localizeFailureMessage(
                    l10n,
                    state.loadErrorMessage ?? l10n.inspectionFormLoadError,
                  ),
                  onRetry: () => context.read<InspectionFormCubit>().load(),
                ),
              ),
            InspectionFormLoadStatus.success => SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  AppSizes.cardPadding,
                  AppSizes.cardPadding,
                  AppSizes.cardPadding,
                  20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InspectionDynamicFormFields(
                      state: state,
                      notesController: _notesController,
                      notesFocusNode: _notesFocusNode,
                      onNotesChanged:
                          context.read<InspectionFormCubit>().onNotesChanged,
                      onConditionChanged:
                          context.read<InspectionFormCubit>().onConditionChanged,
                      onCapturePhoto: _handleCapturePhoto,
                      onCaptureLocation: _handleCaptureLocation,
                      onOpenLocationSettings: () => context
                          .read<InspectionFormCubit>()
                          .openLocationSettings(),
                    ),
                    SizedBox(height: AppSizes.spacingLg),
                    AppOutlineButton(
                      label: state.isSaving
                          ? l10n.inspectionFormSavingDraft
                          : l10n.inspectionFormSaveDraft,
                      icon: Icons.save_outlined,
                      onPressed: state.isSaving
                          ? null
                          : () =>
                              context.read<InspectionFormCubit>().saveDraft(),
                    ),
                    SizedBox(height: AppSizes.spacingSm),
                    AppElevatedButton(
                      label: state.isSaving
                          ? l10n.inspectionFormCompleting
                          : l10n.inspectionFormComplete,
                      icon: Icons.check_circle_outline,
                      onPressed: state.isSaving
                          ? null
                          : () => context
                              .read<InspectionFormCubit>()
                              .completeInspection(),
                    ),
                  ],
                ),
              ),
          },
        );
      },
    );
  }
}
