import 'dart:math';
import 'package:flutter/material.dart';

import 'indicator_painter.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final double angle;

  const PageIndicator({this.currentPage, this.angle});

  Color _getPageIndicatorColor(int pageIndex) {
    return currentPage == pageIndex
        ? Colors.blueGrey.withOpacity(0.7)
        : Colors.white;
  }

  double get indicatorLength => 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: IndicatorPainter(
          color: _getPageIndicatorColor(0),
          startAngle: (3 * pi / 2) + angle,
          indicatorLength: indicatorLength,
        ),
        child: CustomPaint(
          painter: IndicatorPainter(
            color: _getPageIndicatorColor(1),
            startAngle: (pi / 6) + angle,
            indicatorLength: indicatorLength,
          ),
          child: CustomPaint(
            painter: IndicatorPainter(
              color: _getPageIndicatorColor(2),
              startAngle: (5 * pi / 6) + angle,
              indicatorLength: indicatorLength,
            ),
            child: Container(
              height: 70,
              width: 70,
            ),
          ),
        ),
      ),
    );
  }
}
