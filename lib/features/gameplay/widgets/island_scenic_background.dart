import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Full-bleed scenic Nusantara landscape background painter
class IslandScenicBackground extends StatelessWidget {
  final int islandNumber;
  final Widget child;

  const IslandScenicBackground({
    super.key,
    required this.islandNumber,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Base Atmospheric Sky & Sea Gradient
        CustomPaint(
          painter: _IslandLandscapePainter(islandNumber: islandNumber),
          size: Size.infinite,
        ),

        // 2. Subtle Darkening Scrim for high contrast readability of crossword & wheel
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.20),
                Colors.black.withOpacity(0.05),
                Colors.black.withOpacity(0.30),
              ],
            ),
          ),
        ),

        // 3. Foreground Content
        child,
      ],
    );
  }
}

class _IslandLandscapePainter extends CustomPainter {
  final int islandNumber;

  _IslandLandscapePainter({required this.islandNumber});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Palette per Nusantara Island
    List<Color> skyColors;
    Color mountainColor1;
    Color mountainColor2;
    Color waterColor;

    switch (islandNumber) {
      case 1: // Pesisir Bali (Azure blue sky, deep turquoise sea, tropical coast)
        skyColors = const [Color(0xFF38BDF8), Color(0xFF0284C7), Color(0xFF0369A1)];
        mountainColor1 = const Color(0xFF075985).withOpacity(0.65);
        mountainColor2 = const Color(0xFF0C4A6E).withOpacity(0.85);
        waterColor = const Color(0xFF0369A1);
        break;
      case 2: // Kepulauan Rempah (Tropical emerald sea, lush volcanic islands)
        skyColors = const [Color(0xFF34D399), Color(0xFF059669), Color(0xFF047857)];
        mountainColor1 = const Color(0xFF065F46).withOpacity(0.70);
        mountainColor2 = const Color(0xFF064E3B).withOpacity(0.88);
        waterColor = const Color(0xFF047857);
        break;
      case 3: // Lembah Candi (Misty purple/indigo dawn over ancient temples)
        skyColors = const [Color(0xFFA78BFA), Color(0xFF7C3AED), Color(0xFF5B21B6)];
        mountainColor1 = const Color(0xFF4C1D95).withOpacity(0.70);
        mountainColor2 = const Color(0xFF2E1065).withOpacity(0.90);
        waterColor = const Color(0xFF3B0764);
        break;
      case 4: // Rimba Borneo (Deep rainforest mist, canopy greens)
        skyColors = const [Color(0xFF4ADE80), Color(0xFF16A34A), Color(0xFF15803D)];
        mountainColor1 = const Color(0xFF166534).withOpacity(0.72);
        mountainColor2 = const Color(0xFF14532D).withOpacity(0.90);
        waterColor = const Color(0xFF052E16);
        break;
      case 5: // Pesona Raja Ampat (Crystal turquoise lagoon & emerald karsts)
      default:
        skyColors = const [Color(0xFF22D3EE), Color(0xFF0891B2), Color(0xFF0E7490)];
        mountainColor1 = const Color(0xFF155E75).withOpacity(0.70);
        mountainColor2 = const Color(0xFF164E63).withOpacity(0.88);
        waterColor = const Color(0xFF083344);
        break;
    }

    // Paint Sky Gradient
    final skyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: skyColors,
      ).createShader(rect);
    canvas.drawRect(rect, skyPaint);

    // Glowing Sun/Celestial Aura
    final sunPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withOpacity(0.40),
          Colors.white.withOpacity(0.0),
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(size.width * 0.75, size.height * 0.22),
        radius: size.width * 0.45,
      ));
    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.22),
      size.width * 0.45,
      sunPaint,
    );

    // Distant Mountain Ridge 1
    final path1 = Path();
    final h1 = size.height * 0.38;
    path1.moveTo(0, size.height);
    path1.lineTo(0, h1);
    path1.cubicTo(
      size.width * 0.25, h1 - 35,
      size.width * 0.45, h1 + 25,
      size.width * 0.70, h1 - 45,
    );
    path1.cubicTo(
      size.width * 0.85, h1 - 70,
      size.width * 0.95, h1 - 10,
      size.width, h1 - 20,
    );
    path1.lineTo(size.width, size.height);
    path1.close();
    canvas.drawPath(path1, Paint()..color = mountainColor1);

    // Closer Mountain Ridge 2
    final path2 = Path();
    final h2 = size.height * 0.46;
    path2.moveTo(0, size.height);
    path2.lineTo(0, h2);
    path2.cubicTo(
      size.width * 0.20, h2 - 40,
      size.width * 0.40, h2 + 15,
      size.width * 0.55, h2 - 30,
    );
    path2.cubicTo(
      size.width * 0.75, h2 + 20,
      size.width * 0.90, h2 - 25,
      size.width, h2 + 10,
    );
    path2.lineTo(size.width, size.height);
    path2.close();
    canvas.drawPath(path2, Paint()..color = mountainColor2);

    // Water Reflection Base
    final waterHeight = size.height * 0.48;
    final waterRect = Rect.fromLTRB(0, waterHeight, size.width, size.height);
    final waterPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          waterColor.withOpacity(0.55),
          waterColor.withOpacity(0.90),
        ],
      ).createShader(waterRect);
    canvas.drawRect(waterRect, waterPaint);

    // Subtle Water Shimmer Lines
    final shimmerPaint = Paint()
      ..color = Colors.white.withOpacity(0.12)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 6; i++) {
      final y = waterHeight + 20.0 + (i * 24.0);
      final startX = size.width * (0.15 + (i * 0.08) % 0.4);
      final endX = math.min(size.width * 0.9, startX + 90.0 + (i * 15.0));
      canvas.drawLine(Offset(startX, y), Offset(endX, y), shimmerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _IslandLandscapePainter oldDelegate) {
    return oldDelegate.islandNumber != islandNumber;
  }
}
