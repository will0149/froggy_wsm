import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../themes/colors/app_colors.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/18/26

/// PNG del QR de [data] en negro sobre blanco, con el margen que piden los
/// lectores, para compartirlo como imagen.
Future<Uint8List> qrPng(String data, {double size = 600}) async {
  final margin = size / 10;
  final total = size + margin * 2;
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder)
    ..drawRect(Rect.fromLTWH(0, 0, total, total),
        Paint()..color = ParkeaOverlay.qrBackground)
    ..translate(margin, margin);
  QrPainter(
    data: data,
    version: QrVersions.auto,
    eyeStyle: const QrEyeStyle(
        eyeShape: QrEyeShape.square, color: ParkeaOverlay.qrModules),
    dataModuleStyle: const QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square,
        color: ParkeaOverlay.qrModules),
  ).paint(canvas, Size.square(size));
  final image =
      await recorder.endRecording().toImage(total.toInt(), total.toInt());
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  image.dispose();
  return bytes!.buffer.asUint8List();
}
