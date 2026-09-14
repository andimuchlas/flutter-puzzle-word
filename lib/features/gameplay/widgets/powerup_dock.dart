import 'package:flutter/material.dart';
import '../../../../core/theme/island_colors.dart';
import '../../../../core/theme/island_typography.dart';

class PowerupDock extends StatelessWidget {
  final int letterHintCount;
  final int wordHintCount;
  final int checkCount;
  final VoidCallback onLetterHint;
  final VoidCallback onWordHint;
  final VoidCallback onCheck;

  const PowerupDock({
    super.key,
    required this.letterHintCount,
    required this.wordHintCount,
    required this.checkCount,
    required this.onLetterHint,
    required this.onWordHint,
    required this.onCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildPowerupButton(
            icon: Icons.lightbulb,
            iconBg: const Color(0xFFFEF3C7),
            iconColor: const Color(0xFFB45309),
            title: 'Letter',
            subtitle: 'Reveal',
            count: letterHintCount,
            badgeColor: const Color(0xFFF59E0B),
            onTap: onLetterHint,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildPowerupButton(
            icon: Icons.auto_fix_high,
            iconBg: const Color(0xFFE0F2FE),
            iconColor: IslandColors.primaryLight,
            title: 'Word',
            subtitle: 'Reveal',
            count: wordHintCount,
            badgeColor: IslandColors.primaryLight,
            onTap: onWordHint,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildPowerupButton(
            icon: Icons.check_circle_outline,
            iconBg: const Color(0xFFD1FAE5),
            iconColor: IslandColors.gameGreen,
            title: 'Check',
            subtitle: 'Validate',
            count: checkCount,
            badgeColor: IslandColors.gameGreen,
            onTap: onCheck,
          ),
        ),
      ],
    );
  }

  Widget _buildPowerupButton({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required int count,
    required Color badgeColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: IslandColors.outlineLight),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A0F172A),
                  offset: Offset(0, 2),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 16, color: iconColor),
                ),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: IslandTypography.labelSm(
                        color: IslandColors.onSurface,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      subtitle,
                      style: IslandTypography.labelSm(
                        color: IslandColors.onSurfaceVariant,
                      ).copyWith(fontSize: 8.5),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Count Badge
          Positioned(
            top: -4,
            right: -2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(999),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x20000000),
                    offset: Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Text(
                count.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
