

import 'package:flutter/material.dart';

class PartialPainterSmall extends CustomPainter {
  PartialPainterSmall(
      {required this.radius,
        required this.strokeWidth,
        required this.gradient});

  final Paint paintObject = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  @override
  void paint(Canvas canvas, Size size) {
    Rect topLeftTop = Rect.fromLTRB(0, 0, 10, strokeWidth);
    Rect topLeftLeft = Rect.fromLTRB(0, 0, strokeWidth, 10);

    // Rect bottomRightBottom = Rect.fromLTRB(size.width - size.height / 4, size.height - strokeWidth, size.width, size.height);
    // Rect bottomRightRight = Rect.fromLTRB(size.width - strokeWidth, size.height * 3 / 4, size.width, size.height);

    paintObject.shader = gradient.createShader(Offset.zero & size);

    Path topLeftPath = Path()
      ..addRect(topLeftTop)
      ..addRect(topLeftLeft);

    //Path bottomRightPath = Path()
    // ..addRect(bottomRightBottom)
    //..addRect(bottomRightRight);

    Path finalPath = topLeftPath;
    //Path.combine(PathOperation.union, topLeftPath, bottomRightPath);

    canvas.drawPath(finalPath, paintObject);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}