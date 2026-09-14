import 'package:flutter/material.dart';
import '../theme/island_colors.dart';

/// Tactile Card widget with Stitch-styled bottom border elevation
class TactileCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color backgroundColor;
  final Color bevelColor;
  final double shadowHeight;
  final Border? border;

  const TactileCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = 20.0,
    this.backgroundColor = IslandColors.surfaceContainerLowest,
    this.bevelColor = IslandColors.surfaceContainerHighest,
    this.shadowHeight = 4.0,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border ??
            Border.all(
              color: IslandColors.surfaceContainerHighest.withOpacity(0.6),
              width: 1,
            ),
        boxShadow: [
          BoxShadow(
            color: bevelColor,
            offset: Offset(0, shadowHeight),
            blurRadius: 0,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: const Color(0x0A0F172A),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: -2,
          ),
        ],
      ),
      child: child,
    );
  }
}
