import 'package:flutter/material.dart';

class MiddleWaveWhite extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pincel = Paint();
    double width = size.width;
    double height = size.height;

    pincel.color = Colors.white;
    pincel.style = PaintingStyle.fill;
    pincel.strokeWidth = 20;

    final path = Path();
    path.moveTo(width * 0.0, height * 0.45);
    path.lineTo(width * 0.0, height * 0.80);
    path.quadraticBezierTo(
        width * 0.10, height * 0.77, width * 0.16, height * 0.80);
    path.quadraticBezierTo(width * 0.43, height * 0.95, width * 0.50, height * 0.83);
    path.quadraticBezierTo(width * 0.80, height * 0.50, width * 1, height * 0.66);
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
