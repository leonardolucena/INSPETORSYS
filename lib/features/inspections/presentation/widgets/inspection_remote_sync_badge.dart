import 'package:flutter/material.dart';
import 'package:inspetorsys/core/locale/l10n_extensions.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';
import 'package:inspetorsys/theme/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class InspectionRemoteSyncBadge extends StatelessWidget {
  const InspectionRemoteSyncBadge({
    super.key,
    required this.status,
  });

  final InspectionSyncStatus status;

  bool get _isSynced => status == InspectionSyncStatus.synced;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = _isSynced
        ? _BadgeColors(
            background: isDark
                ? AppColors.statusSuccessBgDark
                : AppColors.statusSuccessBg,
            border: isDark
                ? AppColors.statusSuccessBorderDark
                : AppColors.statusSuccessBorder,
            foreground:
                isDark ? AppColors.statusSuccessDark : AppColors.statusSuccess,
          )
        : _BadgeColors(
            background: isDark
                ? AppColors.statusPendingBgDark
                : AppColors.statusPendingBg,
            border: isDark
                ? AppColors.statusPendingBorderDark
                : AppColors.statusPendingBorder,
            foreground:
                isDark ? AppColors.statusPendingDark : AppColors.statusPending,
          );
    final label = _isSynced
        ? l10n.inspectionRemoteSyncSynced
        : l10n.inspectionRemoteSyncNotSynced;

    return Tooltip(
      message: label,
      child: Semantics(
        label: label,
        child: Container(
          padding: EdgeInsets.all(AppSizes.badgePaddingV),
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius),
            border: Border.all(color: colors.border),
          ),
          child: Icon(
            _isSynced ? Icons.cloud_done_outlined : Icons.cloud_off_outlined,
            size: 3.5.w,
            color: colors.foreground,
          ),
        ),
      ),
    );
  }
}

class _BadgeColors {
  const _BadgeColors({
    required this.background,
    required this.border,
    required this.foreground,
  });

  final Color background;
  final Color border;
  final Color foreground;
}
