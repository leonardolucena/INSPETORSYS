abstract interface class MapTileCacheService {
  Future<void> initialize();

  Future<void> prefetchAround({
    required double latitude,
    required double longitude,
  });
}
