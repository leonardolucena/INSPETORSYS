import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inspetorsys/components/connection_indicator.dart';
import 'package:inspetorsys/components/segmented_control.dart';
import 'package:inspetorsys/constants/app_assets.dart';
import 'package:inspetorsys/core/connectivity/network_status.dart';
import 'package:inspetorsys/core/connectivity/presentation/cubit/connection_status_cubit.dart';
import 'package:inspetorsys/components/switch.dart';
import 'package:inspetorsys/core/locale/l10n_extensions.dart';
import 'package:inspetorsys/core/locale/presentation/cubit/locale_cubit.dart';
import 'package:inspetorsys/core/theme/presentation/cubit/theme_cubit.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/core/router/app_routes.dart';
import 'package:inspetorsys/features/auth/domain/entities/user.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/current_user_cubit.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/current_user_state.dart';
import 'package:inspetorsys/features/sync/presentation/cubit/sync_cubit.dart';
import 'package:inspetorsys/features/sync/presentation/cubit/sync_state.dart';
import 'package:inspetorsys/theme/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WorkOrdersDrawer extends StatelessWidget {
  const WorkOrdersDrawer({super.key});

  static void _navigateToWorkOrders(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    Navigator.of(context).pop();

    if (location != AppRoutes.home) {
      context.go(AppRoutes.home);
    }
  }

  static void _navigateToInspectionsHistory(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    Navigator.of(context).pop();

    if (location != AppRoutes.inspectionsHistory) {
      context.push(AppRoutes.inspectionsHistory);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final drawerBackgroundColor = isDark
        ? AppColors.backgroundCardDark
        : AppColors.backgroundCardLight;

    return Drawer(
      width: 78.w,
      backgroundColor: drawerBackgroundColor,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.cardPadding,
            vertical: AppSizes.spacingMd,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset(
                  AppAssets.logoInspetorsys,
                  height: 20.h,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: AppSizes.spacingMd),
              BlocBuilder<ConnectionStatusCubit, NetworkStatus>(
                builder: (context, networkStatus) {
                  return Center(
                    child: AppConnectionIndicator(status: networkStatus),
                  );
                },
              ),
              SizedBox(height: AppSizes.spacingLg),
              _DrawerMenuItem(
                icon: Icons.assignment_outlined,
                label: l10n.drawerWorkOrders,
                onTap: () => _navigateToWorkOrders(context),
              ),
              _DrawerMenuItem(
                icon: Icons.history,
                label: l10n.drawerInspectionsHistory,
                onTap: () => _navigateToInspectionsHistory(context),
              ),
              BlocBuilder<SyncCubit, SyncState>(
                builder: (context, syncState) {
                  return _DrawerMenuItem(
                    icon: Icons.sync,
                    label: l10n.drawerSyncInspections,
                    trailing: syncState.isSyncing
                        ? SizedBox(
                            width: AppSizes.iconMd,
                            height: AppSizes.iconMd,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )
                        : syncState.pendingCount > 0
                            ? _DrawerCountBadge(count: syncState.pendingCount)
                            : null,
                    onTap: syncState.isSyncing
                        ? null
                        : () {
                            Navigator.of(context).pop();
                            context.read<SyncCubit>().syncNow();
                          },
                  );
                },
              ),
              const Spacer(),
              BlocBuilder<LocaleCubit, Locale>(
                builder: (context, locale) {
                  return _DrawerLanguageSelector(
                    selectedLocale: locale,
                    onSelected: (selectedLocale) =>
                        context.read<LocaleCubit>().setLocale(selectedLocale),
                  );
                },
              ),
              SizedBox(height: AppSizes.spacingMd),
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, themeMode) {
                  return _DrawerThemeToggle(
                    isDarkMode: themeMode == ThemeMode.dark,
                    onChanged: (isDark) =>
                        context.read<ThemeCubit>().setDarkMode(isDark),
                  );
                },
              ),
              SizedBox(height: AppSizes.spacingMd),
              BlocBuilder<CurrentUserCubit, CurrentUserState>(
                builder: (context, userState) {
                  return _DrawerProfileSection(
                    user: userState.user,
                    isLoading: userState.status == CurrentUserStatus.loading,
                    userFallbackLabel: l10n.userFallback,
                    onSignOut: () {
                      Navigator.of(context).pop();
                      context.read<AuthSessionCubit>().signOut();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerMenuItem extends StatelessWidget {
  const _DrawerMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;
    final colorScheme = Theme.of(context).colorScheme;
    final contentColor = isEnabled
        ? colorScheme.onSurface
        : colorScheme.onSurface.withValues(alpha: 0.5);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.spacingSm,
          vertical: AppSizes.spacingSm,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: AppSizes.iconMd,
              color: contentColor,
            ),
            SizedBox(width: AppSizes.spacingMd),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: contentColor,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }
}

class _DrawerLanguageSelector extends StatelessWidget {
  const _DrawerLanguageSelector({
    required this.selectedLocale,
    required this.onSelected,
  });

  final Locale selectedLocale;
  final ValueChanged<Locale> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBackgroundColor =
        isDark ? AppColors.backgroundDark : AppColors.listScreenCardLight;
    final borderColor = isDark
        ? AppColors.borderCardDark
        : AppColors.listScreenBorderLight;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.spacingSm,
        vertical: AppSizes.spacingSm,
      ),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                Icons.language_outlined,
                size: AppSizes.iconMd,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              SizedBox(width: AppSizes.spacingMd),
              Expanded(
                child: Text(
                  l10n.drawerLanguage,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.spacingSm),
          AppSegmentedControl<Locale>(
            selected: selectedLocale,
            onSelected: onSelected,
            segments: [
              AppSegmentedControlSegment(
                value: const Locale('pt'),
                label: l10n.languagePortuguese,
              ),
              AppSegmentedControlSegment(
                value: const Locale('en'),
                label: l10n.languageEnglish,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DrawerThemeToggle extends StatelessWidget {
  const _DrawerThemeToggle({
    required this.isDarkMode,
    required this.onChanged,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBackgroundColor =
        isDark ? AppColors.backgroundDark : AppColors.listScreenCardLight;
    final borderColor = isDark
        ? AppColors.borderCardDark
        : AppColors.listScreenBorderLight;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.spacingSm,
        vertical: AppSizes.spacingSm,
      ),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(
            isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
            size: AppSizes.iconMd,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          SizedBox(width: AppSizes.spacingMd),
          Expanded(
            child: Text(
              l10n.drawerDarkMode,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          AppSwitch(
            value: isDarkMode,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _DrawerProfileSection extends StatelessWidget {
  const _DrawerProfileSection({
    required this.user,
    required this.isLoading,
    required this.userFallbackLabel,
    required this.onSignOut,
  });

  final User? user;
  final bool isLoading;
  final String userFallbackLabel;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBackgroundColor =
        isDark ? AppColors.backgroundDark : AppColors.listScreenCardLight;
    final borderColor = isDark
        ? AppColors.borderCardDark
        : AppColors.listScreenBorderLight;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.spacingSm,
        vertical: AppSizes.spacingMd,
      ),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: borderColor),
      ),
      child: isLoading
          ? Center(
              child: SizedBox(
                width: AppSizes.iconLg,
                height: AppSizes.iconLg,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            )
          : Row(
              children: [
                CircleAvatar(
                  radius: AppSizes.iconMd,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    _initialsFor(user?.name),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                SizedBox(width: AppSizes.spacingSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? userFallbackLabel,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      SizedBox(height: AppSizes.spacingXs / 2),
                      Text(
                        user?.email ?? '—',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onSignOut,
                  child: Padding(
                    padding: EdgeInsets.all(AppSizes.spacingXs),
                    child: Icon(
                      Icons.logout,
                      size: AppSizes.iconMd,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  String _initialsFor(String? name) {
    if (name == null || name.trim().isEmpty) {
      return '?';
    }

    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}

class _DrawerCountBadge extends StatelessWidget {
  const _DrawerCountBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final label = count > 99 ? '99+' : '$count';

    return Container(
      constraints: BoxConstraints(
        minWidth: AppSizes.iconMd,
        minHeight: AppSizes.iconMd,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.badgePaddingH,
        vertical: AppSizes.badgePaddingV,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.statusPendingDark : AppColors.statusPending,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isDark
                  ? AppColors.statusPendingBgDark
                  : AppColors.statusPendingBg,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
