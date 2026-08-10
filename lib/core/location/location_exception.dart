sealed class LocationException implements Exception {
  const LocationException(this.message);

  final String message;

  @override
  String toString() => message;
}

final class AppLocationPermissionDeniedException extends LocationException {
  const AppLocationPermissionDeniedException()
      : super('Permissão de localização negada.');
}

final class AppLocationServiceDisabledException extends LocationException {
  const AppLocationServiceDisabledException()
      : super('Serviço de localização desativado.');
}
