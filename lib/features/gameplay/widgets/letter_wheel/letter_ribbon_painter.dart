import 'package:flutter/material.dart';
import '../../../../core/theme/island_colors.dart';

/// CustomPainter that renders a glowing cyan trailing ribbon connecting
/// selected letter nodes in sequence, plus a line to the current finger drag position.
class LetterRibbonPainter extends CustomPainter {
  final List<Offset> letterPositions;
  final List<int> selectedIndices;
  final Offset? currentDragPos;

  LetterRibbonPainter({
    required this.letterPositions,
    required this.selectedIndices,
    this.currentDragPos,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (selectedIndices.isEmpty) return;

    final points = <Offset>[];
    for (final idx in selectedIndices) {
      if (idx >= 0 && idx < letterPositions.length) {
        points.add(letterPositions[idx]);
      }
    }

    if (points.isEmpty) return;

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    if (currentDragPos != null) {
      path.lineTo(currentDragPos!.dx, currentDragPos!.dy);
    }

    // 1. Outer Glow
    final glowPaint = Paint()
      ..color = IslandColors.wheelRibbonGlow.withOpacity(0.4)
      ..strokeWidth = 18.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, glowPaint);

    // 2. Core Ribbon
    final ribbonPaint = Paint()
      ..color = IslandColors.wheelRibbon.withOpacity(0.85)
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, ribbonPaint);

    // 3. Inner bright core
    final corePaint = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, corePaint);
  }

  @override
  bool shouldRepaint(covariant LetterRibbonPainter oldDelegate) {
    return oldDelegate.selectedIndices != selectedIndices ||
        oldDelegate.currentDragPos != currentDragPos ||
        oldDelegate.letterPositions != letterPositions;
  }
}
