import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:inspetorsys/core/maps/map_constants.dart';
import 'package:inspetorsys/core/maps/map_tile_cache_service.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

FMTCTileProvider? _cachedTileProvider;

@LazySingleton(as: MapTileCacheService)
class FmtcMapTileCacheService implements MapTileCacheService {
  var _isInitialized = false;

  @override
  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    await FMTCObjectBoxBackend().initialise();

    final store = FMTCStore(MapConstants.tileStoreName);
    if (!await store.manage.ready) {
      await store.manage.create();
    }

    _cachedTileProvider = FMTCTileProvider(
      stores: {
        MapConstants.tileStoreName: BrowseStoreStrategy.readUpdateCreate,
      },
      loadingStrategy: BrowseLoadingStrategy.cacheFirst,
    );

    _isInitialized = true;
  }

  @override
  Future<void> prefetchAround({
    required double latitude,
    required double longitude,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    final region = CircleRegion(
      LatLng(latitude, longitude),
      MapConstants.prefetchRadiusKm,
    );

    final downloadable = region.toDownloadable(
      minZoom: MapConstants.prefetchMinZoom.round(),
      maxZoom: MapConstants.prefetchMaxZoom.round(),
      options: TileLayer(
        urlTemplate: MapConstants.tileUrlTemplate,
        userAgentPackageName: MapConstants.userAgentPackageName,
      ),
    );

    final download = FMTCStore(MapConstants.tileStoreName)
        .download
        .startForeground(region: downloadable);

    await download.downloadProgress.lastWhere(
      (progress) => progress.remainingTilesCount <= 0,
    );
  }
}

TileProvider? createCachedMapTileProvider() => _cachedTileProvider;
