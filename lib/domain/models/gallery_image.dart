/// Made for parkea.
/// By User: josedominguez
/// Date: 10/18/26
library;

/// Imagen de la galería en el formulario de eventos: una que ya está en el
/// API o una elegida en el teléfono, aún sin subir.
sealed class GalleryImage {
  const GalleryImage();
}

final class StoredImage extends GalleryImage {
  final int id;
  final String url;

  const StoredImage({required this.id, required this.url});
}

final class NewImage extends GalleryImage {
  /// JPEG ya reducido, listo para subir.
  final String path;

  const NewImage(this.path);
}
