abstract final class MapConstants {
  static const String tileUrlTemplate =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const String userAgentPackageName = 'com.example.inspetorsys';
  static const String tileStoreName = 'inspetorsys_map_store';
  static const double defaultLatitude = -23.55052;
  static const double defaultLongitude = -46.633308;
  static const double defaultZoom = 14;
  static const double singlePointZoom = 16;
  static const double minZoom = 3;
  static const double maxZoom = 18;
  static const double zoomStep = 1;
  static const double prefetchRadiusKm = 1;
  static const double prefetchMinZoom = 14;
  static const double prefetchMaxZoom = 16;
}
