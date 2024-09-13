import 'package:flutter/material.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 09/12/24
 */

class MiddleWaveWhite extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pincel = Paint();
    double width = size.width;
    double height = size.height;

    pincel.color = Colors.orangeAccent;
    pincel.style = PaintingStyle.fill;
    pincel.strokeWidth = 20;

    final path = Path();
    path.moveTo(width * 0.0, height * 0.45);
    path.lineTo(width * 0.0, height * 0.90);
    path.quadraticBezierTo(
        width * 0.05, height * 0.78, width * 0.40, height * 0.80);
    path.quadraticBezierTo(width * 0.75, height * 0.80, width * 0.63, height * 0.65);
    path.quadraticBezierTo(width * 0.45, height * 0.45, width * 1, height * 0.56);

    path.lineTo(width * 1, height * 0);
    path.lineTo(width * 0.85, height * 0);
    path.quadraticBezierTo(width * 0.86, height * 0.10, width * 0.55, height * 0.12);
    path.quadraticBezierTo(width * 0.35, height * 0.15, width * 0.46, height * 0.35);
    path.quadraticBezierTo(width * 0.55, height * 0.60, width * 0, height * 0.45);

    canvas.drawPath(path, pincel);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}