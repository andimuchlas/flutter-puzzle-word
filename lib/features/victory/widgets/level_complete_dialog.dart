import 'package:flutter/material.dart';
import '../../../../core/theme/island_colors.dart';
import '../../../../core/theme/island_typography.dart';
import '../../../../core/widgets/tactile_button.dart';

class LevelCompleteDialog extends StatelessWidget {
  final int levelNumber;
  final String islandName;
  final String keyword;
  final int earnedCoins;
  final VoidCallback onNextLevel;
  final VoidCallback onWatchDoubleVideo;
  final VoidCallback onReplay;

  const LevelCompleteDialog({
    super.key,
    required this.levelNumber,
    required this.islandName,
    this.keyword = 'ISLAND',
    this.earnedCoins = 25,
    required this.onNextLevel,
    required this.onWatchDoubleVideo,
    required this.onReplay,
  });

  @override
  Widget build(BuildContext context) {
    final letters = keyword.toUpperCase().split('');

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 380),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                // Main Dialog Card
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 24),
                  decoration: BoxDecoration(
                    color: IslandColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: IslandColors.surfaceContainerHighest,
                      width: 1.5,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x25006194),
                        offset: Offset(0, 12),
                        blurRadius: 32,
                        spreadRadius: -4,
                      ),
                      BoxShadow(
                        color: IslandColors.surfaceContainerHighest,
                        offset: Offset(0, 4),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Headline
                      Text(
                        'SPECTACULAR!',
                        style: IslandTypography.displayLg(
                          color: IslandColors.primary,
                        ).copyWith(fontSize: 28, letterSpacing: -0.5),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'You uncovered the secret archipelago word!',
                        textAlign: TextAlign.center,
                        style: IslandTypography.bodySm(
                          color: IslandColors.onSurfaceVariant,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Keyword Letter Tiles (Tilted tactile tiles)
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          for (int i = 0; i < letters.length; i++)
                            _buildTactileTile(letters[i], i),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // 3 Stars Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Star 1
                          Transform.rotate(
                            angle: -0.15,
                            child: _buildStar(44, IslandColors.secondaryContainer),
                          ),
                          const SizedBox(width: 8),
                          // Star 2 (center, larger, elevated)
                          Transform.translate(
                            offset: const Offset(0, -8),
                            child: _buildStar(56, IslandColors.secondaryContainer),
                          ),
                          const SizedBox(width: 8),
                          // Star 3
                          Transform.rotate(
                            angle: 0.15,
                            child: _buildStar(44, IslandColors.secondaryContainer),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Reward Cards (Coins & Star Crest)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: IslandColors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Coins Reward
                            Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: IslandColors.secondaryContainer,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: IslandColors.secondaryDark,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.monetization_on,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '+$earnedCoins',
                                      style: IslandTypography.labelLg(
                                        color: IslandColors.onSurface,
                                      ),
                                    ),
                                    Text(
                                      'Coins',
                                      style: IslandTypography.labelSm(
                                        color: IslandColors.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Container(
                              width: 1,
                              height: 28,
                              color: IslandColors.surfaceContainerHighest,
                            ),

                            // Star Crest Reward
                            Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: IslandColors.tertiaryContainer,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: IslandColors.tertiary,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.hotel_class,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '+1 Star',
                                      style: IslandTypography.labelLg(
                                        color: IslandColors.onSurface,
                                      ),
                                    ),
                                    Text(
                                      'Island Crest',
                                      style: IslandTypography.labelSm(
                                        color: IslandColors.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Level Progress Bar
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: IslandColors.surfaceContainer,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  islandName,
                                  style: IslandTypography.labelSm(
                                    color: IslandColors.primary,
                                  ).copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Level $levelNumber of 30',
                                  style: IslandTypography.labelSm(
                                    color: IslandColors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(999),
                              child: LinearProgressIndicator(
                                value: (levelNumber % 30) / 30.0,
                                minHeight: 8,
                                backgroundColor:
                                    IslandColors.surfaceContainerHighest,
                                valueColor: const AlwaysStoppedAnimation(
                                  IslandColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // CTA Buttons
                      // 1. NEXT LEVEL (Emerald Green CTA)
                      TactileButton(
                        onPressed: onNextLevel,
                        backgroundColor: IslandColors.tertiaryContainer,
                        bevelColor: IslandColors.tertiary,
                        shadowHeight: 5,
                        width: double.infinity,
                        height: 52,
                        borderRadius: 16,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'NEXT LEVEL',
                              style: IslandTypography.headlineSm(
                                color: Colors.white,
                              ).copyWith(letterSpacing: 0.5),
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 22,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      // 2. Watch Video for 2x Coins
                      TactileButton(
                        onPressed: onWatchDoubleVideo,
                        backgroundColor: IslandColors.secondaryContainer,
                        bevelColor: IslandColors.secondaryDark,
                        shadowHeight: 4,
                        width: double.infinity,
                        height: 48,
                        borderRadius: 14,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.play_circle_fill,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Watch Video for 2x Coins (+${earnedCoins * 2})',
                              style: IslandTypography.labelLg(
                                color: IslandColors.onSecondaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Replay button
                      TextButton.icon(
                        onPressed: onReplay,
                        icon: const Icon(
                          Icons.replay,
                          size: 18,
                          color: IslandColors.onSurfaceVariant,
                        ),
                        label: Text(
                          'Replay Level',
                          style: IslandTypography.labelSm(
                            color: IslandColors.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Top Floating Beacon (Sun icon + Perfection pill)
                Positioned(
                  top: 0,
                  child: Column(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: const BoxDecoration(
                          color: IslandColors.secondaryContainer,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: IslandColors.secondaryDark,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.wb_sunny,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(999),
                            boxShadow: const [
                              BoxShadow(
                                color: IslandColors.surfaceContainerHighest,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.celebration,
                                size: 14,
                                color: IslandColors.secondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'PERFECTION!',
                                style: IslandTypography.labelSm(
                                  color: IslandColors.secondary,
                                ).copyWith(
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTactileTile(String char, int index) {
    final rotations = [-0.03, 0.02, -0.02, 0.03, -0.03, 0.04];
    final rotation = rotations[index % rotations.length];

    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: IslandColors.secondaryContainer,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: IslandColors.secondaryDark,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            char,
            style: IslandTypography.titleTile(
              color: IslandColors.onSecondaryContainer,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStar(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: IslandColors.surfaceContainerHigh,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: IslandColors.outlineVariant,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Icon(
        Icons.star,
        size: size * 0.65,
        color: color,
      ),
    );
  }
}
