import 'package:flutter/material.dart';
import 'dart:math' as math;

class ClockMarks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ClockMarksPainter(),
    );
  }
}

class ClockMarksPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    Offset center = Offset(size.width / 2, size.height / 2);

    double markRadius = radius + 145; // 調整刻度的半徑
    double markLength = 20.0; // 調整刻度的長度

    // 繪製時鐘刻度
    Paint markPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 12; i++) {
      double angle = (i * 30) * (math.pi / 180); // 每個刻度30度
      double startX = center.dx + markRadius * math.cos(angle);
      double startY = center.dy + markRadius * math.sin(angle);

      double endX = center.dx + (markRadius + markLength) * math.cos(angle);
      double endY = center.dy + (markRadius + markLength) * math.sin(angle);

      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), markPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}