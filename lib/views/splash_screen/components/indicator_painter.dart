import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndicatorPainter extends CustomPainter {
  final Color color;
  final double startAngle;
  final double indicatorLength;

  const IndicatorPainter({
    this.color,
     this.startAngle,
     this.indicatorLength,
  })  : assert(color != null),
        assert(startAngle != null),
        assert(indicatorLength != null);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: (size.shortestSide + 12.0) / 2,
      ),
      startAngle,
      indicatorLength,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(IndicatorPainter oldDelegate) {
    return this.color != oldDelegate.color ||
        this.startAngle != oldDelegate.startAngle;
  }
}
