import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:inspetorsys/core/maps/fmtc_map_tile_cache_service.dart';
import 'package:inspetorsys/core/maps/app_map_point.dart';
import 'package:inspetorsys/core/maps/map_constants.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/theme/app_colors.dart';
import 'package:latlong2/latlong.dart';

class AppMap extends StatefulWidget {
  const AppMap({
    super.key,
    required this.points,
    this.height,
    this.interactive = true,
    this.markerColor,
    this.controlIconColor,
  });

  final List<AppMapPoint> points;
  final double? height;
  final bool interactive;
  final Color? markerColor;
  final Color? controlIconColor;

  @override
  State<AppMap> createState() => _AppMapState();
}

class _AppMapState extends State<AppMap> {
  final MapController _mapController = MapController();

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _recenterOnMarkers() {
    _recenterMapOnMarkers(_mapController, widget.points);
  }

  void _zoomBy(double delta) {
    _zoomMapBy(_mapController, delta);
  }

  Future<void> _openFullscreen() async {
    final camera = _mapController.camera;

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Theme.of(context).colorScheme.scrim.withValues(alpha: 0.5),
      builder: (dialogContext) => _AppMapFullscreenDialog(
        points: widget.points,
        initialCenter: camera.center,
        initialZoom: camera.zoom,
        markerColor: widget.markerColor,
        controlIconColor: widget.controlIconColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _AppMapFrame(
      height: widget.height ?? AppSizes.mapHeight,
      child: Stack(
        children: [
          _AppMapView(
            mapController: _mapController,
            points: widget.points,
            interactive: widget.interactive,
            markerColor: widget.markerColor,
          ),
          if (widget.interactive) ...[
            Positioned(
              top: AppSizes.spacingSm,
              left: AppSizes.spacingSm,
              child: _MapControlButton(
                icon: Icons.fullscreen,
                tooltip: 'Expandir mapa',
                onPressed: _openFullscreen,
                iconColor: widget.controlIconColor,
              ),
            ),
            Positioned(
              top: AppSizes.spacingSm,
              right: AppSizes.spacingSm,
              child: _MapControlsColumn(
                onRecenter:
                    widget.points.isNotEmpty ? _recenterOnMarkers : null,
                onZoomIn: () => _zoomBy(MapConstants.zoomStep),
                onZoomOut: () => _zoomBy(-MapConstants.zoomStep),
                iconColor: widget.controlIconColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AppMapFullscreenDialog extends StatefulWidget {
  const _AppMapFullscreenDialog({
    required this.points,
    required this.initialCenter,
    required this.initialZoom,
    this.markerColor,
    this.controlIconColor,
  });

  final List<AppMapPoint> points;
  final LatLng initialCenter;
  final double initialZoom;
  final Color? markerColor;
  final Color? controlIconColor;

  @override
  State<_AppMapFullscreenDialog> createState() =>
      _AppMapFullscreenDialogState();
}

class _AppMapFullscreenDialogState extends State<_AppMapFullscreenDialog> {
  final MapController _mapController = MapController();

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _recenterOnMarkers() {
    _recenterMapOnMarkers(_mapController, widget.points);
  }

  void _zoomBy(double delta) {
    _zoomMapBy(_mapController, delta);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.05,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0),
      child: SizedBox(
        width: size.width * 0.9,
        height: size.height * 0.9,
        child: _AppMapFrame(
          child: Stack(
            fit: StackFit.expand,
            children: [
            _AppMapView(
              mapController: _mapController,
              points: widget.points,
              interactive: true,
              initialCenter: widget.initialCenter,
              initialZoom: widget.initialZoom,
              markerColor: widget.markerColor,
            ),
            Positioned(
              top: AppSizes.spacingSm,
              right: AppSizes.spacingSm,
              child: _MapControlsColumn(
                onClose: () => Navigator.of(context).pop(),
                onRecenter:
                    widget.points.isNotEmpty ? _recenterOnMarkers : null,
                onZoomIn: () => _zoomBy(MapConstants.zoomStep),
                onZoomOut: () => _zoomBy(-MapConstants.zoomStep),
                iconColor: widget.controlIconColor,
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}

class _AppMapFrame extends StatelessWidget {
  const _AppMapFrame({
    required this.child,
    this.height,
  });

  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? AppColors.borderCardDark
        : AppColors.primaryTextColorLight.withValues(alpha: 0.15);
    final backgroundColor = isDark
        ? AppColors.backgroundCardDark
        : AppColors.backgroundCardLight;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          color: backgroundColor,
        ),
        child: height == null
            ? SizedBox.expand(child: child)
            : SizedBox(height: height, child: child),
      ),
    );
  }
}

class _AppMapView extends StatelessWidget {
  const _AppMapView({
    required this.mapController,
    required this.points,
    required this.interactive,
    this.initialCenter,
    this.initialZoom,
    this.markerColor,
  });

  final MapController mapController;
  final List<AppMapPoint> points;
  final bool interactive;
  final LatLng? initialCenter;
  final double? initialZoom;
  final Color? markerColor;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: _buildMapOptions(
        context: context,
        points: points,
        interactive: interactive,
        initialCenter: initialCenter,
        initialZoom: initialZoom,
      ),
      children: [
        TileLayer(
          urlTemplate: MapConstants.tileUrlTemplate,
          userAgentPackageName: MapConstants.userAgentPackageName,
          tileProvider: createCachedMapTileProvider(),
        ),
        if (points.isNotEmpty)
          MarkerLayer(
            markers: points
                .map(
                  (point) => _buildMarker(
                    context,
                    point,
                    markerColorOverride: markerColor,
                  ),
                )
                .toList(),
          ),
        RichAttributionWidget(
          alignment: AttributionAlignment.bottomRight,
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _MapControlsColumn extends StatelessWidget {
  const _MapControlsColumn({
    required this.onZoomIn,
    required this.onZoomOut,
    this.onRecenter,
    this.onClose,
    this.iconColor,
  });

  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback? onRecenter;
  final VoidCallback? onClose;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (onClose != null) ...[
          _MapControlButton(
            icon: Icons.close,
            tooltip: 'Fechar',
            onPressed: onClose!,
            iconColor: iconColor,
          ),
          SizedBox(height: AppSizes.spacingXs),
        ],
        if (onRecenter != null) ...[
          _MapControlButton(
            icon: Icons.my_location,
            tooltip: 'Centralizar no marcador',
            onPressed: onRecenter!,
            iconColor: iconColor,
          ),
          SizedBox(height: AppSizes.spacingXs),
        ],
        _MapZoomControls(
          onZoomIn: onZoomIn,
          onZoomOut: onZoomOut,
          iconColor: iconColor,
        ),
      ],
    );
  }
}

class _MapZoomControls extends StatelessWidget {
  const _MapZoomControls({
    required this.onZoomIn,
    required this.onZoomOut,
    this.iconColor,
  });

  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final chrome = _resolveMapControlChrome(
      context,
      customIconColor: iconColor,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: chrome.backgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        border: Border.all(color: chrome.borderColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _MapControlButton(
            icon: Icons.add,
            tooltip: 'Aumentar zoom',
            onPressed: onZoomIn,
            showBorder: false,
            iconColor: iconColor,
            chrome: chrome,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSizes.borderRadius),
            ),
          ),
          Divider(height: 1, thickness: 1, color: chrome.borderColor),
          _MapControlButton(
            icon: Icons.remove,
            tooltip: 'Diminuir zoom',
            onPressed: onZoomOut,
            showBorder: false,
            iconColor: iconColor,
            chrome: chrome,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(AppSizes.borderRadius),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapControlChrome {
  const _MapControlChrome({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
}

_MapControlChrome _resolveMapControlChrome(
  BuildContext context, {
  Color? customIconColor,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final useLightChrome = customIconColor != null;

  if (useLightChrome) {
    return _MapControlChrome(
      backgroundColor: AppColors.backgroundCardLight,
      borderColor: AppColors.listScreenBorderLight,
      iconColor: customIconColor,
    );
  }

  return _MapControlChrome(
    backgroundColor:
        isDark ? AppColors.backgroundCardDark : AppColors.backgroundCardLight,
    borderColor: isDark
        ? AppColors.borderCardDark
        : AppColors.primaryTextColorLight.withValues(alpha: 0.15),
    iconColor: Theme.of(context).colorScheme.primary,
  );
}

class _MapControlButton extends StatelessWidget {
  const _MapControlButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.showBorder = true,
    this.borderRadius,
    this.iconColor,
    this.chrome,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool showBorder;
  final BorderRadius? borderRadius;
  final Color? iconColor;
  final _MapControlChrome? chrome;

  @override
  Widget build(BuildContext context) {
    final resolvedChrome = chrome ??
        _resolveMapControlChrome(
          context,
          customIconColor: iconColor,
        );

    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onPressed,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: resolvedChrome.backgroundColor,
            borderRadius:
                borderRadius ?? BorderRadius.circular(AppSizes.borderRadius),
            border: showBorder
                ? Border.all(color: resolvedChrome.borderColor)
                : null,
          ),
          child: Padding(
            padding: EdgeInsets.all(AppSizes.spacingSm),
            child: Icon(
              icon,
              size: AppSizes.iconMd,
              color: resolvedChrome.iconColor,
            ),
          ),
        ),
      ),
    );
  }
}

void _recenterMapOnMarkers(
  MapController mapController,
  List<AppMapPoint> points,
) {
  final coordinates = points.map((point) => point.latLng).toList();
  if (coordinates.isEmpty) {
    return;
  }

  if (coordinates.length == 1) {
    mapController.move(
      coordinates.first,
      MapConstants.singlePointZoom,
    );
    return;
  }

  mapController.fitCamera(
    CameraFit.coordinates(
      coordinates: coordinates,
      padding: EdgeInsets.all(AppSizes.cardPadding),
    ),
  );
}

void _zoomMapBy(MapController mapController, double delta) {
  final camera = mapController.camera;
  final newZoom = (camera.zoom + delta).clamp(
    MapConstants.minZoom,
    MapConstants.maxZoom,
  );

  if (newZoom == camera.zoom) {
    return;
  }

  mapController.move(camera.center, newZoom);
}

MapOptions _buildMapOptions({
  required BuildContext context,
  required List<AppMapPoint> points,
  required bool interactive,
  LatLng? initialCenter,
  double? initialZoom,
}) {
  final coordinates = points.map((point) => point.latLng).toList();
  final backgroundColor = Theme.of(context).brightness == Brightness.dark
      ? AppColors.backgroundCardDark
      : AppColors.backgroundCardLight;
  final interactionOptions = InteractionOptions(
    flags: interactive ? InteractiveFlag.all : InteractiveFlag.none,
  );

  if (initialCenter != null && initialZoom != null) {
    return MapOptions(
      initialCenter: initialCenter,
      initialZoom: initialZoom,
      minZoom: MapConstants.minZoom,
      maxZoom: MapConstants.maxZoom,
      backgroundColor: backgroundColor,
      interactionOptions: interactionOptions,
    );
  }

  if (coordinates.isEmpty) {
    return MapOptions(
      initialCenter: const LatLng(
        MapConstants.defaultLatitude,
        MapConstants.defaultLongitude,
      ),
      initialZoom: MapConstants.defaultZoom,
      minZoom: MapConstants.minZoom,
      maxZoom: MapConstants.maxZoom,
      backgroundColor: backgroundColor,
      interactionOptions: interactionOptions,
    );
  }

  if (coordinates.length == 1) {
    return MapOptions(
      initialCenter: coordinates.first,
      initialZoom: MapConstants.singlePointZoom,
      minZoom: MapConstants.minZoom,
      maxZoom: MapConstants.maxZoom,
      backgroundColor: backgroundColor,
      interactionOptions: interactionOptions,
    );
  }

  return MapOptions(
    initialCenter: coordinates.first,
    initialZoom: MapConstants.defaultZoom,
    minZoom: MapConstants.minZoom,
    maxZoom: MapConstants.maxZoom,
    initialCameraFit: CameraFit.coordinates(
      coordinates: coordinates,
      padding: EdgeInsets.all(AppSizes.cardPadding),
    ),
    backgroundColor: backgroundColor,
    interactionOptions: interactionOptions,
  );
}

Marker _buildMarker(
  BuildContext context,
  AppMapPoint point, {
  Color? markerColorOverride,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  final markerColor = markerColorOverride ??
      switch (point.type) {
        AppMapPointType.workOrder => colorScheme.primary,
        AppMapPointType.inspection => AppColors.statusSuccess,
      };

  return Marker(
    point: point.latLng,
    width: AppSizes.mapMarkerSize,
    height: AppSizes.mapMarkerSize,
    alignment: Alignment.bottomCenter,
    child: Tooltip(
      message: point.label,
      child: Icon(
        Icons.location_on,
        color: markerColor,
        size: AppSizes.mapMarkerSize,
      ),
    ),
  );
}
