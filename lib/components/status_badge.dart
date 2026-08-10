import 'package:flutter/material.dart';
import 'package:inspetorsys/core/locale/l10n_extensions.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/l10n/app_localizations.dart';
import 'package:inspetorsys/theme/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum AppSyncStatus {
  draft,
  pending,
  synced,
  failed,
}

class AppStatusBadge extends StatelessWidget {
  const AppStatusBadge({
    super.key,
    required this.status,
    this.label,
  });

  final AppSyncStatus status;
  final String? label;

  String _labelFor(AppLocalizations l10n) => switch (status) {
        AppSyncStatus.draft => l10n.syncStatusDraft,
        AppSyncStatus.pending => l10n.syncStatusPending,
        AppSyncStatus.synced => l10n.syncStatusSynced,
        AppSyncStatus.failed => l10n.syncStatusFailed,
      };

  IconData get _icon => switch (status) {
        AppSyncStatus.draft => Icons.edit_outlined,
        AppSyncStatus.pending => Icons.hourglass_top_outlined,
        AppSyncStatus.synced => Icons.check_circle_outline,
        AppSyncStatus.failed => Icons.error_outline,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = _resolveColors(isDark);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.badgePaddingH,
        vertical: AppSizes.badgePaddingV,
      ),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _icon,
            size: 3.5.w,
            color: colors.foreground,
          ),
          SizedBox(width: AppSizes.spacingXs),
          Text(
            label ?? _labelFor(l10n),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colors.foreground,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  _BadgeColors _resolveColors(bool isDark) {
    return switch (status) {
      AppSyncStatus.draft => _BadgeColors(
          background:
              isDark ? AppColors.statusDraftBgDark : AppColors.statusDraftBg,
          border: isDark
              ? AppColors.statusDraftBorderDark
              : AppColors.statusDraftBorder,
          foreground:
              isDark ? AppColors.statusDraftDark : AppColors.statusDraft,
        ),
      AppSyncStatus.pending => _BadgeColors(
          background: isDark
              ? AppColors.statusPendingBgDark
              : AppColors.statusPendingBg,
          border: isDark
              ? AppColors.statusPendingBorderDark
              : AppColors.statusPendingBorder,
          foreground:
              isDark ? AppColors.statusPendingDark : AppColors.statusPending,
        ),
      AppSyncStatus.synced => _BadgeColors(
          background: isDark
              ? AppColors.statusSuccessBgDark
              : AppColors.statusSuccessBg,
          border: isDark
              ? AppColors.statusSuccessBorderDark
              : AppColors.statusSuccessBorder,
          foreground:
              isDark ? AppColors.statusSuccessDark : AppColors.statusSuccess,
        ),
      AppSyncStatus.failed => _BadgeColors(
          background:
              isDark ? AppColors.statusDangerBgDark : AppColors.statusDangerBg,
          border: isDark
              ? AppColors.statusDangerBorderDark
              : AppColors.statusDangerBorder,
          foreground:
              isDark ? AppColors.statusDangerDark : AppColors.statusDanger,
        ),
    };
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
