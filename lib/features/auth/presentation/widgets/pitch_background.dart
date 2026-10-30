import 'package:flutter/material.dart';

import '../../../../core/config/app_colors.dart';

/// Night-stadium backdrop: dark gradient with faint pitch markings.
class PitchBackground extends StatelessWidget {
  const PitchBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
      child: CustomPaint(painter: _PitchLinesPainter(), child: child),
    );
  }
}

class _PitchLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final w = size.width;
    final h = size.height;
    final margin = w * 0.06;

    // Touchlines
    canvas.drawRect(
      Rect.fromLTRB(margin, margin, w - margin, h - margin),
      paint,
    );

    // Halfway line and centre circle
    canvas.drawLine(Offset(margin, h / 2), Offset(w - margin, h / 2), paint);
    canvas.drawCircle(Offset(w / 2, h / 2), w * 0.18, paint);

    // Penalty boxes
    final boxWidth = w * 0.56;
    final boxHeight = h * 0.13;
    final boxLeft = (w - boxWidth) / 2;
    canvas.drawRect(Rect.fromLTWH(boxLeft, margin, boxWidth, boxHeight), paint);
    canvas.drawRect(
      Rect.fromLTWH(boxLeft, h - margin - boxHeight, boxWidth, boxHeight),
      paint,
    );

    // Floodlight glow at the top
    final glow = Paint()
      ..shader =
          RadialGradient(
            colors: [
              AppColors.primary.withValues(alpha: 0.12),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(center: Offset(w / 2, 0), radius: w * 0.8),
          );
    canvas.drawCircle(Offset(w / 2, 0), w * 0.8, glow);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
