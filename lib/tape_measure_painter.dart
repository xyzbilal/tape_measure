
import 'package:flutter/material.dart';

class TapeMeasurePainter extends CustomPainter {
  double value;
  double min;
  double max;
  double step;
  String unit;

  TapeMeasurePainter(this.value, this.min, this.max, this.step, this.unit);

  final Paint bgFill = Paint()
    ..color = Color(0xFFDBAE0C)
    ..style = PaintingStyle.fill;

  final Paint fgBorder = Paint()
    ..color = Color(0xFF090700)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  final Paint indicatorBorder = Paint()
    ..color = Color(0xFFEC0606)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  @override
  void paint(Canvas canvas, Size size) {
    final bgRect = Offset.zero & size;
    canvas.drawRect(bgRect, bgFill);
    canvas.drawRect(bgRect, fgBorder);
    final innerRect = bgRect.deflate(5);
    canvas.drawRect(innerRect, fgBorder);
    canvas.clipRect(innerRect);
    drawMarkers(canvas, innerRect);
    drawValue(canvas, innerRect);
    drawIndicator(canvas, innerRect);
  }

  void drawMarkers(Canvas canvas, Rect innerRect) {
    double range = max - min;
    double stepSize = innerRect.width / range;
    double heightSmall = 10;
    double heightMedium = 15;
    double heightLarge = 20;
    double offsetToIndicator = innerRect.width / 2 - (value - min) * stepSize;

    for (double i = min; i <= max; i += step) {
      double x = innerRect.left + (i - min) * stepSize + offsetToIndicator;
      double yL = innerRect.top + heightLarge;
      if (i % 10 == 0) {
        canvas.drawLine(Offset(x, innerRect.top), Offset(x, yL), fgBorder);
        TextSpan span = TextSpan(
            style: const TextStyle(color: Colors.black, fontSize: 10),
            text: i.toStringAsFixed(0));
        TextPainter tp = TextPainter(
            text: span,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr);
        tp.layout();
        tp.paint(canvas, Offset(x - tp.width / 2, yL + 5));
      } else if (i % 5 == 0) {
        canvas.drawLine(Offset(x, innerRect.top),
            Offset(x, innerRect.top + heightMedium), fgBorder);
      } else {
        canvas.drawLine(Offset(x, innerRect.top),
            Offset(x, innerRect.top + heightSmall), fgBorder);
      }
    }
  }

  void drawValue(Canvas canvas, Rect innerRect) {
    final c = innerRect.bottomCenter;

    TextSpan span = TextSpan(
        style: const TextStyle(color: Colors.black, fontSize: 20),
        text: "${value.toStringAsFixed(1)} $unit");
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(c.dx - tp.width / 2, c.dy - tp.height));
  }

  void drawIndicator(Canvas canvas, Rect innerRect) {
    final c1 = innerRect.topCenter + Offset(0, innerRect.height / 4);
    final c2 = innerRect.center + Offset(0, innerRect.height / 4);
    canvas.drawLine(c1, c2, indicatorBorder);
  }

  @override
  bool shouldRepaint(TapeMeasurePainter oldDelegate) {
    return true;
  }
}
