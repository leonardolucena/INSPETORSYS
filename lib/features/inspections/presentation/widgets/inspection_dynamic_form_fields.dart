import 'package:flutter/material.dart';
import 'package:inspetorsys/core/image/inspection_photo_image.dart';
import 'package:inspetorsys/components/card.dart';
import 'package:inspetorsys/components/elevated_button.dart';
import 'package:inspetorsys/components/inline_button.dart';
import 'package:inspetorsys/components/radio.dart';
import 'package:inspetorsys/components/text_field.dart';
import 'package:inspetorsys/core/location/geo_coordinates.dart';
import 'package:inspetorsys/core/locale/l10n_extensions.dart';
import 'package:inspetorsys/core/locale/localized_labels.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_schema.dart';
import 'package:inspetorsys/features/inspections/domain/constants/inspection_geofence_constants.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_condition.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_form_field_type.dart';
import 'package:inspetorsys/features/inspections/presentation/cubit/inspection_form_state.dart';
import 'package:inspetorsys/theme/app_surface_colors.dart';
import 'package:inspetorsys/theme/app_colors.dart';
import 'package:inspetorsys/theme/app_text_theme.dart';

class InspectionDynamicFormFields extends StatelessWidget {
  const InspectionDynamicFormFields({
    super.key,
    required this.state,
    required this.notesController,
    required this.notesFocusNode,
    required this.onNotesChanged,
    required this.onConditionChanged,
    required this.onCapturePhoto,
    required this.onCaptureLocation,
    required this.onOpenLocationSettings,
  });

  final InspectionFormState state;
  final TextEditingController notesController;
  final FocusNode notesFocusNode;
  final ValueChanged<String> onNotesChanged;
  final ValueChanged<InspectionCondition?> onConditionChanged;
  final VoidCallback onCapturePhoto;
  final VoidCallback onCaptureLocation;
  final VoidCallback onOpenLocationSettings;

  @override
  Widget build(BuildContext context) {
    final schema = state.formSchema;
    if (schema == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final field in schema.fields) ...[
          _buildField(context, field),
          SizedBox(height: AppSizes.spacingSm),
        ],
      ],
    );
  }

  Widget _buildField(BuildContext context, InspectionFormFieldSchema field) {
    return switch (field.type) {
      InspectionFormFieldType.text when field.key == 'observation' =>
        _ObservationField(
          field: field,
          state: state,
          notesController: notesController,
          notesFocusNode: notesFocusNode,
          onNotesChanged: onNotesChanged,
        ),
      InspectionFormFieldType.photo => _PhotoField(
          field: field,
          state: state,
          onCapturePhoto: onCapturePhoto,
        ),
      InspectionFormFieldType.location => _LocationField(
          field: field,
          state: state,
          onCaptureLocation: onCaptureLocation,
          onOpenLocationSettings: onOpenLocationSettings,
        ),
      InspectionFormFieldType.select when field.key == 'condition' =>
        _ConditionField(
          field: field,
          state: state,
          onConditionChanged: onConditionChanged,
        ),
      _ => const SizedBox.shrink(),
    };
  }

  static Color _cardBackgroundColor(BuildContext context) {
    return AppSurfaceColors.elevatedSurface(context);
  }

  static Widget sectionCard(
    BuildContext context, {
    required Widget child,
    EdgeInsetsGeometry? padding,
  }) {
    return AppCard(
      backgroundColor: _cardBackgroundColor(context),
      showBorder: false,
      padding: padding,
      child: child,
    );
  }
}

class _ObservationField extends StatelessWidget {
  const _ObservationField({
    required this.field,
    required this.state,
    required this.notesController,
    required this.notesFocusNode,
    required this.onNotesChanged,
  });

  final InspectionFormFieldSchema field;
  final InspectionFormState state;
  final TextEditingController notesController;
  final FocusNode notesFocusNode;
  final ValueChanged<String> onNotesChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final minLength = field.minLength ?? state.observationMinLength;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          localizedInspectionFormFieldLabel(l10n, field),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: AppSizes.spacingXs),
        AppTextField(
          controller: notesController,
          focusNode: notesFocusNode,
          label: '',
          errorText: localizeValidationMessage(l10n, state.notesError),
          helperText: l10n.inspectionFormNotesMinLength(minLength),
          reserveErrorSpace: false,
          minLines: 5,
          maxLines: 8,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          onChanged: onNotesChanged,
        ),
      ],
    );
  }
}

class _PhotoField extends StatelessWidget {
  const _PhotoField({
    required this.field,
    required this.state,
    required this.onCapturePhoto,
  });

  final InspectionFormFieldSchema field;
  final InspectionFormState state;
  final VoidCallback onCapturePhoto;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          localizedInspectionFormFieldLabel(l10n, field),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: AppSizes.spacingSm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppElevatedButton(
              label: state.isCapturingPhoto
                  ? l10n.inspectionFormOpeningCamera
                  : state.photoPath == null
                      ? l10n.inspectionFormCapturePhoto
                      : l10n.inspectionFormRetakePhoto,
              icon: Icons.photo_camera_outlined,
              onPressed: state.isCapturingPhoto ? null : onCapturePhoto,
            ),
            if (state.photoPath != null) ...[
              SizedBox(height: AppSizes.spacingMd),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                child: InspectionPhotoImage(
                  photoReference: state.photoPath,
                  height: AppSizes.mapHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (state.photoSizeBytes != null) ...[
                SizedBox(height: AppSizes.spacingXs),
                Text(
                  l10n.inspectionFormCompressedImage(
                    (state.photoSizeBytes! / 1024).toStringAsFixed(0),
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
            if (state.photoError != null) ...[
              SizedBox(height: AppSizes.spacingSm),
              Text(
                localizeValidationMessage(l10n, state.photoError)!,
                style: AppTextTheme.error,
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _LocationField extends StatelessWidget {
  const _LocationField({
    required this.field,
    required this.state,
    required this.onCaptureLocation,
    required this.onOpenLocationSettings,
  });

  final InspectionFormFieldSchema field;
  final InspectionFormState state;
  final VoidCallback onCaptureLocation;
  final VoidCallback onOpenLocationSettings;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          localizedInspectionFormFieldLabel(l10n, field),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: AppSizes.spacingSm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppElevatedButton(
              label: state.isCapturingLocation
                  ? l10n.inspectionFormGettingLocation
                  : state.coordinates == null
                      ? l10n.inspectionFormCaptureGps
                      : l10n.inspectionFormUpdateGps,
              icon: Icons.my_location_outlined,
              onPressed:
                  state.isCapturingLocation ? null : onCaptureLocation,
            ),
            if (state.coordinates != null) ...[
              SizedBox(height: AppSizes.spacingMd),
              _LocationInfo(coordinates: state.coordinates!),
            ],
            if (state.distanceFromWorkOrderMeters != null &&
                state.workOrderLatitude != null &&
                state.workOrderLongitude != null) ...[
              SizedBox(height: AppSizes.spacingSm),
              _GeofenceWarningBanner(
                distanceMeters: state.distanceFromWorkOrderMeters!,
              ),
            ],
            if (state.locationError != null) ...[
              SizedBox(height: AppSizes.spacingSm),
              Text(
                localizeValidationMessage(l10n, state.locationError)!,
                style: AppTextTheme.error,
              ),
            ],
            if (state.showLocationSettingsAction) ...[
              SizedBox(height: AppSizes.spacingSm),
              AppInlineButton(
                label: l10n.inspectionFormOpenSettings,
                icon: Icons.settings_outlined,
                onPressed: onOpenLocationSettings,
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _ConditionField extends StatelessWidget {
  const _ConditionField({
    required this.field,
    required this.state,
    required this.onConditionChanged,
  });

  final InspectionFormFieldSchema field;
  final InspectionFormState state;
  final ValueChanged<InspectionCondition?> onConditionChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final options = field.options
        .map(InspectionConditionX.fromApiValue)
        .whereType<InspectionCondition>()
        .toList();

    final half = (options.length / 2).ceil();
    final leftOptions = options.sublist(0, half);
    final rightOptions = options.sublist(half);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          localizedInspectionFormFieldLabel(l10n, field),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: AppSizes.spacingSm),
        InspectionDynamicFormFields.sectionCard(
          context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _buildConditionOptions(
                        context: context,
                        options: leftOptions,
                        groupValue: state.condition,
                        onChanged: onConditionChanged,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _buildConditionOptions(
                        context: context,
                        options: rightOptions,
                        groupValue: state.condition,
                        onChanged: onConditionChanged,
                      ),
                    ),
                  ),
                ],
              ),
              if (state.conditionError != null) ...[
                SizedBox(height: AppSizes.spacingXs),
                Text(
                  localizeValidationMessage(l10n, state.conditionError)!,
                  style: AppTextTheme.error,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildConditionOptions({
    required BuildContext context,
    required List<InspectionCondition> options,
    required InspectionCondition? groupValue,
    required ValueChanged<InspectionCondition?> onChanged,
  }) {
    final l10n = context.l10n;
    final children = <Widget>[];

    for (var index = 0; index < options.length; index++) {
      if (index > 0) {
        children.add(SizedBox(height: AppSizes.spacingLg));
      }

      final condition = options[index];
      children.add(
        AppRadio<InspectionCondition>(
          dense: true,
          label: condition.localizedLabel(l10n),
          value: condition,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
      );
    }

    return children;
  }
}

class _GeofenceWarningBanner extends StatelessWidget {
  const _GeofenceWarningBanner({required this.distanceMeters});

  final double distanceMeters;

  @override
  Widget build(BuildContext context) {
    if (distanceMeters <= InspectionGeofenceConstants.warningRadiusMeters) {
      return const SizedBox.shrink();
    }

    final l10n = context.l10n;
    final message = localizedGeofenceWarning(
      l10n,
      distanceMeters: distanceMeters,
    );
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(AppSizes.spacingSm),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.statusPendingBgDark
            : AppColors.statusPendingBg,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        border: Border.all(
          color: isDark
              ? AppColors.statusPendingBorderDark
              : AppColors.statusPendingBorder,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_outlined,
            color: isDark
                ? AppColors.statusPendingDark
                : AppColors.statusPending,
          ),
          SizedBox(width: AppSizes.spacingSm),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? AppColors.statusPendingDark
                        : AppColors.statusPending,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationInfo extends StatelessWidget {
  const _LocationInfo({required this.coordinates});

  final GeoCoordinates coordinates;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final accuracyLabel = coordinates.accuracyMeters == null
        ? null
        : l10n.inspectionFormAccuracy(
            coordinates.accuracyMeters!.toStringAsFixed(0),
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.inspectionFormLatitude(coordinates.latitude.toStringAsFixed(5)),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: AppSizes.spacingXs),
        Text(
          l10n.inspectionFormLongitude(coordinates.longitude.toStringAsFixed(5)),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        if (accuracyLabel != null) ...[
          SizedBox(height: AppSizes.spacingXs),
          Text(
            accuracyLabel,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ],
    );
  }
}
