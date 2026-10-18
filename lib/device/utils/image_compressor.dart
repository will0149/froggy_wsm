import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'logger_config.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/18/26

/// Límite del API por imagen de evento.
const maxEventImageBytes = 2 * 1024 * 1024;

/// Intentos de mayor a menor calidad: lado mayor en px y calidad JPEG. El
/// primero basta para casi cualquier foto (200–600 KB); los demás son para
/// imágenes con mucho detalle.
const _attempts = [(1600, 85), (1600, 70), (1280, 70)];

/// Convierte la imagen de [path] a JPEG de 1600 px como máximo, con la
/// rotación de la cámara aplicada y sin EXIF (no se publica la ubicación de
/// la foto). Devuelve la ruta del archivo nuevo o null si no se pudo dejar
/// por debajo de [maxEventImageBytes].
Future<String?> compressEventImage(String path) async {
  final dir = await Directory.systemTemp.createTemp('event_image');
  for (final (side, quality) in _attempts) {
    try {
      final file = await FlutterImageCompress.compressAndGetFile(
        path,
        '${dir.path}/${side}_$quality.jpg',
        minWidth: side,
        minHeight: side,
        quality: quality,
        format: CompressFormat.jpeg,
      );
      if (file != null && await file.length() <= maxEventImageBytes) {
        return file.path;
      }
    } on Exception catch (e) {
      logger.e('compressEventImage: $e');
      return null;
    }
  }
  return null;
}
