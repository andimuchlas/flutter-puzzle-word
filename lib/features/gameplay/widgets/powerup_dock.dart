import 'package:flutter/material.dart';
import '../../../../core/theme/island_colors.dart';
import '../../../../core/theme/island_typography.dart';
import '../../../../l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context);
    final isId = Localizations.localeOf(context).languageCode.startsWith('id');

    return Row(
      children: [
        Expanded(
          child: _buildPowerupButton(
            icon: Icons.lightbulb,
            iconBg: const Color(0xFFFEF3C7),
            iconColor: const Color(0xFFB45309),
            title: isId ? 'Huruf' : 'Letter',
            subtitle: l10n?.hint ?? 'Hint',
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
            title: isId ? 'Kata' : 'Word',
            subtitle: isId ? 'Buka' : 'Reveal',
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
            title: isId ? 'Cek' : 'Check',
            subtitle: isId ? 'Periksa' : 'Validate',
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
      behavior: HitTestBehavior.opaque,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 18, color: iconColor),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: IslandTypography.labelSm(
                          color: IslandColors.onSurface,
                        ).copyWith(fontWeight: FontWeight.bold, fontSize: 11),
                      ),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: IslandTypography.labelSm(
                          color: IslandColors.onSurfaceVariant,
                        ).copyWith(fontSize: 9),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Count Badge
          Positioned(
            top: -4,
            right: -2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
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
                  fontSize: 9.5,
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
