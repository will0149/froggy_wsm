import 'package:flutter/material.dart';

class SignInUpWhiteShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pincel = Paint();
    double width = size.width;
    double height = size.height;

    pincel.color = Colors.white;
    pincel.style = PaintingStyle.fill;
    pincel.strokeWidth = 20;

    final path = Path();
    path.lineTo(width * 0.0, height * 0.80);
    path.quadraticBezierTo(
        width * 0.30, height * 0.65, width * 0.50, height * 0.75);
    path.quadraticBezierTo(width * 0.65, height * 0.85, width * 0.78, height * 0.79);
    path.quadraticBezierTo(width * 0.90, height * 0.76, width * 1, height * 0.82);

    path.lineTo(width * 1, height * 0);
    path.lineTo(width * 0.85, height * 0);
    path.lineTo(0, 0);


    canvas.drawPath(path, pincel);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
