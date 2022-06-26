import 'package:flutter/material.dart';
import 'package:parkea/app/colors.dart';

class BottomLeftCurveOrange extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pincel = Paint();
    double width = size.width;
    double height = size.height;

    pincel.color = parkeaOrange;
    pincel.style = PaintingStyle.fill;
    pincel.strokeWidth = 20;

    final path = Path();
    path.moveTo(width * 0.0, height * 1);
    path.lineTo(width * 0.0, height * 0.80);
    path.quadraticBezierTo(
        width * 0.10, height * 0.77, width * 0.20, height * 0.80);
    path.quadraticBezierTo(
        width * 0.30, height * 0.84, width * 0.29, height * 0.90);
    path.quadraticBezierTo(
        width * 0.28, height * 0.97, width * 0.48, height * 1);
    path.lineTo(width * 0, height * 1);

    canvas.drawPath(path, pincel);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}