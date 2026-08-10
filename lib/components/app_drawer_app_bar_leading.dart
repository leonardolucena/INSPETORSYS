import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';

class AppDrawerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppDrawerAppBar({
    super.key,
    required this.title,
    this.backgroundColor,
    this.showBackButton = true,
  });

  final String title;
  final Color? backgroundColor;
  final bool showBackButton;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final leadingWidth = AppDrawerAppBarLeading.leadingWidthFor(
      showBackButton: showBackButton,
    );

    return AppBar(
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leadingWidth: leadingWidth,
      leading: AppDrawerAppBarLeading(showBackButton: showBackButton),
      title: const SizedBox.shrink(),
      flexibleSpace: SafeArea(
        bottom: false,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: leadingWidth),
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}

class AppDrawerAppBarLeading extends StatelessWidget {
  const AppDrawerAppBarLeading({
    super.key,
    this.showBackButton = true,
  });

  final bool showBackButton;

  static double leadingWidth({bool showBackButton = true}) =>
      leadingWidthFor(showBackButton: showBackButton);

  static double leadingWidthFor({bool showBackButton = true}) {
    return showBackButton
        ? AppSizes.drawerAppBarLeadingWidth
        : AppSizes.drawerAppBarLeadingWidthCompact;
  }

  @override
  Widget build(BuildContext context) {
    final leadingWidth = leadingWidthFor(showBackButton: showBackButton);

    return SizedBox(
      width: leadingWidth,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showBackButton)
            _DrawerAppBarIconButton(
              tooltip: 'Voltar',
              icon: Icons.arrow_back,
              onPressed: () => context.pop(),
            ),
          _DrawerAppBarIconButton(
            tooltip: 'Menu',
            icon: Icons.menu,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ],
      ),
    );
  }
}

class _DrawerAppBarIconButton extends StatelessWidget {
  const _DrawerAppBarIconButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final size = AppSizes.drawerAppBarIconButtonWidth;

    return SizedBox(
      width: size,
      height: kToolbarHeight,
      child: IconButton(
        tooltip: tooltip,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        constraints: BoxConstraints(
          minWidth: size,
          maxWidth: size,
          minHeight: kToolbarHeight,
          maxHeight: kToolbarHeight,
        ),
        icon: Icon(icon),
      ),
    );
  }
}
