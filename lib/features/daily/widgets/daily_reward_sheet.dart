import 'package:flutter/material.dart';
import '../../../../core/services/game_state.dart';
import '../../../../core/theme/island_colors.dart';
import '../../../../core/theme/island_typography.dart';
import '../../../../core/widgets/tactile_button.dart';

class DailyRewardSheet extends StatelessWidget {
  const DailyRewardSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: GameState(),
      builder: (context, _) {
        final gameState = GameState();

        return Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          decoration: const BoxDecoration(
            color: IslandColors.surfaceContainerLowest,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Sheet handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: IslandColors.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'Daily Island Gift',
                style: IslandTypography.headlineMd(color: IslandColors.onSurface),
              ),
              const SizedBox(height: 4),
              Text(
                'Come back every day for free hints and bonus coins!',
                textAlign: TextAlign.center,
                style: IslandTypography.bodySm(color: IslandColors.onSurfaceVariant),
              ),
              const SizedBox(height: 20),

              // 7 Days Streak Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int day = 1; day <= 5; day++)
                    _buildDayRewardItem(
                      day: day,
                      isToday: day == 3,
                      isClaimed: day < 3 || (day == 3 && gameState.dailyClaimed),
                      rewardText: day == 3 ? '100 + 💡' : '${day * 25}',
                    ),
                ],
              ),

              const SizedBox(height: 24),

              TactileButton(
                onPressed: gameState.dailyClaimed
                    ? null
                    : () {
                        gameState.claimDailyGift();
                        Navigator.of(context).pop();
                      },
                backgroundColor: gameState.dailyClaimed
                    ? IslandColors.outlineVariant
                    : IslandColors.secondaryContainer,
                bevelColor: gameState.dailyClaimed
                    ? IslandColors.outline
                    : IslandColors.secondaryDark,
                shadowHeight: 4,
                width: double.infinity,
                height: 48,
                borderRadius: 14,
                child: Text(
                  gameState.dailyClaimed ? 'CLAIMED TODAY' : 'CLAIM TODAY (+100 COINS)',
                  style: IslandTypography.labelLg(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDayRewardItem({
    required int day,
    required bool isToday,
    required bool isClaimed,
    required String rewardText,
  }) {
    return Container(
      width: 58,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isToday
            ? IslandColors.surfaceContainer
            : (isClaimed
                ? IslandColors.surfaceContainerLow
                : IslandColors.surfaceContainerLowest),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isToday
              ? IslandColors.primaryLight
              : IslandColors.surfaceContainerHighest,
          width: isToday ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Day $day',
            style: IslandTypography.labelSm(
              color: isToday
                  ? IslandColors.primaryLight
                  : IslandColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 6),
          Icon(
            isClaimed ? Icons.check_circle : Icons.monetization_on,
            size: 22,
            color: isClaimed
                ? IslandColors.gameGreen
                : IslandColors.secondaryContainer,
          ),
          const SizedBox(height: 4),
          Text(
            rewardText,
            style: IslandTypography.labelSm(color: IslandColors.onSurface)
                .copyWith(fontSize: 9),
          ),
        ],
      ),
    );
  }
}
