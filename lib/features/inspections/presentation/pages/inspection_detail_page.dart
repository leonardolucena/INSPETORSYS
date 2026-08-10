import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspetorsys/components/accent_underline_text.dart';
import 'package:inspetorsys/components/app_drawer_app_bar_leading.dart';
import 'package:inspetorsys/components/app_map.dart';
import 'package:inspetorsys/components/card.dart';
import 'package:inspetorsys/components/status_badge.dart';
import 'package:inspetorsys/components/states/app_error_state.dart';
import 'package:inspetorsys/components/states/screen_loading_shimmers.dart';
import 'package:inspetorsys/core/image/inspection_photo_image.dart';
import 'package:inspetorsys/core/locale/l10n_extensions.dart';
import 'package:inspetorsys/core/locale/localized_labels.dart';
import 'package:inspetorsys/core/maps/app_map_point.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/core/utils/app_date_formatter.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_data.dart';
import 'package:inspetorsys/features/inspections/presentation/cubit/inspection_detail_cubit.dart';
import 'package:inspetorsys/features/inspections/presentation/cubit/inspection_detail_state.dart';
import 'package:inspetorsys/features/inspections/presentation/mappers/inspection_sync_status_mapper.dart';
import 'package:inspetorsys/features/inspections/presentation/widgets/inspection_remote_sync_badge.dart';
import 'package:inspetorsys/features/work_orders/presentation/widgets/work_orders_drawer.dart';
import 'package:inspetorsys/l10n/app_localizations.dart';
import 'package:inspetorsys/theme/app_surface_colors.dart';

class InspectionDetailPage extends StatefulWidget {
  const InspectionDetailPage({
    super.key,
    required this.clientId,
  });

  final String clientId;

  @override
  State<InspectionDetailPage> createState() => _InspectionDetailPageState();
}

class _InspectionDetailPageState extends State<InspectionDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<InspectionDetailCubit>().load(widget.clientId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InspectionDetailCubit, InspectionDetailState>(
      builder: (context, state) {
        final l10n = context.l10n;
        final screenBackgroundColor = AppSurfaceColors.screenBackground(context);

        return Scaffold(
          backgroundColor: screenBackgroundColor,
          drawer: const WorkOrdersDrawer(),
          appBar: AppDrawerAppBar(
            title: l10n.inspectionDetailTitle,
            backgroundColor: screenBackgroundColor,
          ),
          body: switch (state.status) {
            InspectionDetailStatus.initial ||
            InspectionDetailStatus.loading =>
              Padding(
                padding: EdgeInsets.all(AppSizes.cardPadding),
                child: const WorkOrderDetailShimmer(),
              ),
            InspectionDetailStatus.failure => Padding(
                padding: EdgeInsets.all(AppSizes.cardPadding),
                child: AppErrorState(
                  message: localizeFailureMessage(
                    l10n,
                    state.errorMessage ?? l10n.inspectionDetailLoadError,
                  ),
                  onRetry: () => context
                      .read<InspectionDetailCubit>()
                      .load(widget.clientId),
                ),
              ),
            InspectionDetailStatus.success => _buildContent(
                context,
                state,
                l10n,
              ),
          },
        );
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    InspectionDetailState state,
    AppLocalizations l10n,
  ) {
    final inspection = state.inspection!;
    final cardBackgroundColor = AppSurfaceColors.elevatedSurface(context);
    final workOrderLabel =
        state.workOrderCode ?? inspection.workOrderCode ?? inspection.workOrderId;
    final condition = inspectionCondition(inspection);
    final mapPoints = _buildMapPoints(
      inspection: inspection,
      workOrderLabel: workOrderLabel,
    );

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSizes.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppCard(
            backgroundColor: cardBackgroundColor,
            showBorder: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AppAccentUnderlineText(label: workOrderLabel),
                    ),
                    SizedBox(width: AppSizes.spacingSm),
                    Wrap(
                      spacing: AppSizes.spacingXs,
                      runSpacing: AppSizes.spacingXs,
                      alignment: WrapAlignment.end,
                      children: [
                        InspectionRemoteSyncBadge(status: inspection.status),
                        AppStatusBadge(status: inspection.status.badgeStatus),
                      ],
                    ),
                  ],
                ),
                if (state.workOrderTitle != null) ...[
                  SizedBox(height: AppSizes.spacingXs),
                  Text(
                    state.workOrderTitle!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
                SizedBox(height: AppSizes.spacingSm),
                _DetailRow(
                  label: l10n.inspectionDetailCreatedAtLabel,
                  value: inspection.createdAt.toDateTimeLabel,
                ),
                SizedBox(height: AppSizes.spacingXs),
                _DetailRow(
                  label: l10n.inspectionDetailUpdatedAtLabel,
                  value: inspection.updatedAt.toDateTimeLabel,
                ),
                if (inspection.syncedAt != null) ...[
                  SizedBox(height: AppSizes.spacingXs),
                  _DetailRow(
                    label: l10n.inspectionDetailSyncedAtLabel,
                    value: inspection.syncedAt!.toDateTimeLabel,
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: AppSizes.spacingMd),
          AppCard(
            backgroundColor: cardBackgroundColor,
            showBorder: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.inspectionFormFieldObservation,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: AppSizes.spacingXs),
                Text(
                  inspection.notes?.trim().isNotEmpty == true
                      ? inspection.notes!.trim()
                      : l10n.inspectionDetailEmptyValue,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: AppSizes.spacingMd),
                Text(
                  l10n.inspectionFormFieldCondition,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: AppSizes.spacingXs),
                Text(
                  condition?.localizedLabel(l10n) ??
                      l10n.inspectionDetailEmptyValue,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          if (inspection.photoPath != null) ...[
            SizedBox(height: AppSizes.spacingMd),
            AppCard(
              backgroundColor: cardBackgroundColor,
              showBorder: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.inspectionFormFieldPhoto,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: AppSizes.spacingSm),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                    child: InspectionPhotoImage(
                      photoReference: inspection.photoPath,
                      height: AppSizes.mapHeight,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (mapPoints.isNotEmpty) ...[
            SizedBox(height: AppSizes.spacingMd),
            AppCard(
              backgroundColor: cardBackgroundColor,
              showBorder: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.inspectionFormFieldLocation,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  if (inspection.latitude != null &&
                      inspection.longitude != null) ...[
                    SizedBox(height: AppSizes.spacingXs),
                    Text(
                      l10n.inspectionFormLatitude(
                        inspection.latitude!.toStringAsFixed(6),
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      l10n.inspectionFormLongitude(
                        inspection.longitude!.toStringAsFixed(6),
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                  SizedBox(height: AppSizes.spacingSm),
                  AppMap(points: mapPoints),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<AppMapPoint> _buildMapPoints({
    required Inspection inspection,
    required String workOrderLabel,
  }) {
    final points = <AppMapPoint>[];

    final workOrderLatitude = inspection.workOrderLatitude;
    final workOrderLongitude = inspection.workOrderLongitude;
    if (workOrderLatitude != null && workOrderLongitude != null) {
      points.add(
        AppMapPoint(
          latitude: workOrderLatitude,
          longitude: workOrderLongitude,
          label: workOrderLabel,
          type: AppMapPointType.workOrder,
        ),
      );
    }

    final latitude = inspection.latitude;
    final longitude = inspection.longitude;
    if (latitude != null && longitude != null) {
      points.add(
        AppMapPoint(
          latitude: latitude,
          longitude: longitude,
          label: workOrderLabel,
          type: AppMapPointType.inspection,
        ),
      );
    }

    return points;
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.7),
                ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
