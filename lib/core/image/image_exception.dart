sealed class ImageException implements Exception {
  const ImageException(this.message);

  final String message;

  @override
  String toString() => message;
}

final class ImagePermissionDeniedException extends ImageException {
  const ImagePermissionDeniedException()
      : super('Permissão de câmera negada.');
}

final class ImageCaptureCancelledException extends ImageException {
  const ImageCaptureCancelledException()
      : super('Captura de foto cancelada.');
}

final class ImageCompressionException extends ImageException {
  const ImageCompressionException()
      : super('Não foi possível comprimir a imagem.');
}
