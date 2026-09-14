import 'package:flutter/material.dart';
import '../../../../core/services/game_state.dart';
import '../../../../core/theme/island_colors.dart';
import '../../../../core/theme/island_typography.dart';
import '../../../../core/widgets/tactile_button.dart';
import '../../../../l10n/app_localizations.dart';

class ShopSheet extends StatelessWidget {
  const ShopSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      decoration: const BoxDecoration(
        color: IslandColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
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
            l10n?.archipelagoShop ?? 'Archipelago Shop',
            style: IslandTypography.headlineMd(color: IslandColors.onSurface),
          ),
          const SizedBox(height: 4),
          Text(
            l10n?.shopSubtitle ?? 'Support the game with one-time purchases and powerup bundles',
            textAlign: TextAlign.center,
            style: IslandTypography.bodySm(color: IslandColors.onSurfaceVariant),
          ),
          const SizedBox(height: 20),

          // Remove Ads Card (Transparent one-time purchase)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: IslandColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: IslandColors.surfaceContainerHighest),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: IslandColors.primaryFixed,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.block,
                    color: IslandColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n?.removeAds ?? 'Remove All Ads',
                        style: IslandTypography.headlineSm(
                          color: IslandColors.onSurface,
                        ).copyWith(fontSize: 14),
                      ),
                      Text(
                        l10n?.removeAdsDesc ?? 'Permanent one-time purchase. Enjoy ad-free crossword solving.',
                        style: IslandTypography.bodySm(
                          color: IslandColors.onSurfaceVariant,
                        ).copyWith(fontSize: 10.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                TactileButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ads removed! Thank you.')),
                    );
                    Navigator.of(context).pop();
                  },
                  backgroundColor: IslandColors.primary,
                  bevelColor: IslandColors.primaryDark,
                  shadowHeight: 3,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    '\$2.99',
                    style: IslandTypography.labelMd(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Powerup Pack Card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: IslandColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: IslandColors.surfaceContainerHighest),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: IslandColors.secondaryFixed,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.inventory_2,
                    color: IslandColors.secondary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n?.explorerBundle ?? 'Explorer Bundle',
                        style: IslandTypography.headlineSm(
                          color: IslandColors.onSurface,
                        ).copyWith(fontSize: 14),
                      ),
                      Text(
                        l10n?.explorerBundleDesc ?? '5 Hints + 3 Word Reveals + 500 Coins',
                        style: IslandTypography.bodySm(
                          color: IslandColors.onSurfaceVariant,
                        ).copyWith(fontSize: 10.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                TactileButton(
                  onPressed: () {
                    GameState().addCoins(500);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Bundle purchased! Added 500 coins.')),
                    );
                    Navigator.of(context).pop();
                  },
                  backgroundColor: IslandColors.secondaryContainer,
                  bevelColor: IslandColors.secondaryDark,
                  shadowHeight: 3,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    '\$1.99',
                    style: IslandTypography.labelMd(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
