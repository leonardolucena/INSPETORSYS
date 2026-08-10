import 'dart:async';

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
  var _nextDownloadInstanceId = 1;
  late FMTCStore _store;
  Future<void> _prefetchQueue = Future<void>.value();

  @override
  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    await FMTCObjectBoxBackend().initialise();

    _store = FMTCStore(MapConstants.tileStoreName);
    if (!await _store.manage.ready) {
      await _store.manage.create();
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
  }) {
    _prefetchQueue = _prefetchQueue.then(
      (_) => _prefetchAroundInternal(
        latitude: latitude,
        longitude: longitude,
      ),
    );

    return _prefetchQueue;
  }

  Future<void> _prefetchAroundInternal({
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

    final instanceId = _nextDownloadInstanceId++;

    try {
      final download = _store.download.startForeground(
        region: downloadable,
        instanceId: instanceId,
        skipExistingTiles: true,
      );

      await download.downloadProgress
          .timeout(const Duration(minutes: 5))
          .lastWhere((progress) => progress.remainingTilesCount <= 0);
    } on TimeoutException {
      await _store.download.cancel(instanceId: instanceId);
    } catch (_) {
      await _store.download.cancel(instanceId: instanceId);
    }
  }
}

TileProvider? createCachedMapTileProvider() => _cachedTileProvider;
