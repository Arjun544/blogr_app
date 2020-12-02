import 'dart:math';

import 'package:flutter/material.dart';

class ContainerPainter extends CustomPainter {
  ContainerPainter({@required this.color, @required this.avatarRadius});

  static const double _margin = 6;
  final Color color;
  final double avatarRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final shapeBounds =
        Rect.fromLTWH(0, 0, size.width, size.height - avatarRadius);

    final centerAvatar = Offset(shapeBounds.center.dx, shapeBounds.bottom);
    final avatarRect =
        Rect.fromCircle(center: centerAvatar, radius: avatarRadius)
            .inflate(_margin);

    _drawBackground(canvas, shapeBounds, avatarRect);
  }

  void _drawBackground(Canvas canvas, Rect bounds, Rect avatarRect) {
    final paint = Paint()..color = color;

    final backgroundPath = Path()
      ..moveTo(bounds.left, bounds.top)
      ..lineTo(bounds.bottomLeft.dx, bounds.bottomLeft.dy)
      ..arcTo(avatarRect, -pi, pi, false)
      ..lineTo(bounds.bottomRight.dx, bounds.bottomRight.dy)
      ..lineTo(bounds.topRight.dx, bounds.topRight.dy)
      ..close();

    canvas.drawPath(backgroundPath, paint);
  }

  @override
  bool shouldRepaint(ContainerPainter oldDelegate) {
    return avatarRadius != oldDelegate.avatarRadius ||
        color != oldDelegate.color;
  }
}
