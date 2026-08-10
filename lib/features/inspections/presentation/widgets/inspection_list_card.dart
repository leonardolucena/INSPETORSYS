import 'package:flutter/material.dart';
import 'package:inspetorsys/components/accent_underline_text.dart';
import 'package:inspetorsys/components/outline_button.dart';
import 'package:inspetorsys/components/card.dart';
import 'package:inspetorsys/components/status_badge.dart';
import 'package:inspetorsys/core/locale/l10n_extensions.dart';
import 'package:inspetorsys/core/locale/localized_labels.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/core/utils/app_date_formatter.dart';
import 'package:inspetorsys/features/inspections/domain/entities/local_inspection_list_item.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';
import 'package:inspetorsys/features/inspections/presentation/mappers/inspection_sync_status_mapper.dart';
import 'package:inspetorsys/features/inspections/presentation/widgets/inspection_remote_sync_badge.dart';
import 'package:inspetorsys/theme/app_surface_colors.dart';
import 'package:inspetorsys/theme/app_text_theme.dart';

class InspectionListCard extends StatelessWidget {
  const InspectionListCard({
    super.key,
    required this.item,
    this.isRetrying = false,
    this.onRetry,
    this.onTap,
    this.invertedSurface = false,
  });

  final LocalInspectionListItem item;
  final bool isRetrying;
  final VoidCallback? onRetry;
  final VoidCallback? onTap;
  final bool invertedSurface;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final inspection = item.inspection;
    final workOrderLabel = item.workOrderCode ?? inspection.workOrderId;
    final errorMessage = inspection.syncErrorMessage?.trim();
    final backgroundColor = invertedSurface
        ? AppSurfaceColors.elevatedSurface(context)
        : null;
    final borderColor = invertedSurface
        ? AppSurfaceColors.cardBorder(context)
        : null;

    return AppCard(
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      showBorder: !invertedSurface,
      margin: EdgeInsets.only(bottom: AppSizes.spacingMd),
      onTap: onTap,
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
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  InspectionRemoteSyncBadge(status: inspection.status),
                  AppStatusBadge(status: inspection.status.badgeStatus),
                ],
              ),
            ],
          ),
          if (item.workOrderTitle != null) ...[
            SizedBox(height: AppSizes.spacingXs),
            Text(
              item.workOrderTitle!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
          SizedBox(height: AppSizes.spacingXs),
          Text(
            AppDateFormatter.formatDateTime(inspection.updatedAt),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (inspection.status == InspectionSyncStatus.failed &&
              errorMessage != null &&
              errorMessage.isNotEmpty) ...[
            SizedBox(height: AppSizes.spacingSm),
            Text(
              localizeFailureMessage(l10n, errorMessage),
              style: AppTextTheme.error,
            ),
          ],
          if (inspection.status == InspectionSyncStatus.failed &&
              onRetry != null) ...[
            SizedBox(height: AppSizes.spacingSm),
            Align(
              alignment: Alignment.centerLeft,
              child: AppOutlineButton(
                label: l10n.retryAction,
                icon: Icons.refresh,
                expand: false,
                enabled: !isRetrying,
                onPressed: isRetrying ? null : onRetry,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
