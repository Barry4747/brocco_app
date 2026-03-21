import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ConnectorLine extends StatelessWidget {
  final double fromX, fromY, toX, toY;
  final bool isCompleted;

  const ConnectorLine({
    super.key,
    required this.fromX,
    required this.fromY,
    required this.toX,
    required this.toY,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _LinePainter(
        from: Offset(fromX, fromY),
        to: Offset(toX, toY),
        color: isCompleted
            ? AppColors.accentGreen
            : AppColors.accentGreen.withOpacity(0.35),
        strokeWidth: isCompleted ? 3 : 2,
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  final Offset from;
  final Offset to;
  final Color color;
  final double strokeWidth;

  _LinePainter({
    required this.from,
    required this.to,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final midX = (from.dx + to.dx) / 2;
    final path = Path()
      ..moveTo(from.dx, from.dy)
      ..cubicTo(midX, from.dy, midX, to.dy, to.dx, to.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_LinePainter oldDelegate) =>
      from != oldDelegate.from ||
      to != oldDelegate.to ||
      color != oldDelegate.color;
}
