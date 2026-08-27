import 'package:flutter/material.dart';

/// A container with a dashed border, since [BoxDecoration.border] only
/// supports solid strokes. Used for upload drop-zones (e.g. Figma's
/// "Upload Property Image" placeholder).
class DashedBorderContainer extends StatelessWidget {
  const DashedBorderContainer({
    super.key,
    required this.child,
    this.color = const Color(0xFFBDBDBD),
    this.strokeWidth = 2,
    this.radius = 8,
    this.gap = 4,
  });

  final Widget child;
  final Color color;
  final double strokeWidth;
  final double radius;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(color: color, strokeWidth: strokeWidth, radius: radius, gap: gap),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({required this.color, required this.strokeWidth, required this.radius, required this.gap});

  final Color color;
  final double strokeWidth;
  final double radius;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(strokeWidth / 2, strokeWidth / 2, size.width - strokeWidth, size.height - strokeWidth),
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + gap), paint);
        distance += gap * 2;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth || oldDelegate.radius != radius || oldDelegate.gap != gap;
}
