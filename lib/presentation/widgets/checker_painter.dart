import 'package:flutter/material.dart';

class CheckerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double cellSize = 20;
    final paint1 = Paint()..color = const Color(0xFF1A1A1A);
    final paint2 = Paint()..color = const Color(0xFF252525);

    for (double y = 0; y < size.height; y += cellSize) {
      for (double x = 0; x < size.width; x += cellSize) {
        final isEven =
            ((x / cellSize).toInt() + (y / cellSize).toInt()) % 2 == 0;
        canvas.drawRect(
          Rect.fromLTWH(x, y, cellSize, cellSize),
          isEven ? paint1 : paint2,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
