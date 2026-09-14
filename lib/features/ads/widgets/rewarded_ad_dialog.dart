import 'package:flutter/material.dart';
import '../../../../core/services/game_state.dart';
import '../../../../core/theme/island_colors.dart';
import '../../../../core/theme/island_typography.dart';
import '../../../../core/widgets/tactile_button.dart';

class RewardedAdDialog extends StatelessWidget {
  final String rewardDescription;
  final VoidCallback onRewardGranted;

  const RewardedAdDialog({
    super.key,
    this.rewardDescription = '1 Free Hint',
    required this.onRewardGranted,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: IslandColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: IslandColors.surfaceContainerHighest),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F006194),
              offset: Offset(0, 8),
              blurRadius: 24,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: IslandColors.secondaryFixed,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.ondemand_video,
                color: IslandColors.secondary,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Need a little help?',
              style: IslandTypography.headlineMd(color: IslandColors.onSurface),
            ),
            const SizedBox(height: 6),
            Text(
              'Watch a short video sponsor to receive $rewardDescription. This is completely optional.',
              textAlign: TextAlign.center,
              style: IslandTypography.bodySm(color: IslandColors.onSurfaceVariant),
            ),
            const SizedBox(height: 24),

            TactileButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Simulate quick rewarded video completion
                GameState().addCoins(50);
                onRewardGranted();
              },
              backgroundColor: IslandColors.secondaryContainer,
              bevelColor: IslandColors.secondaryDark,
              shadowHeight: 4,
              width: double.infinity,
              height: 48,
              borderRadius: 14,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.play_arrow, color: Colors.white, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    'WATCH VIDEO',
                    style: IslandTypography.labelLg(color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'No thanks',
                style: IslandTypography.bodySm(color: IslandColors.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
