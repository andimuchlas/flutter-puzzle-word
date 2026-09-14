import 'package:flutter/material.dart';
import '../theme/island_colors.dart';
import '../theme/island_typography.dart';

class IslandCoinBadge extends StatelessWidget {
  final int coins;
  final VoidCallback? onAddTap;

  const IslandCoinBadge({
    super.key,
    required this.coins,
    this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: IslandColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: IslandColors.surfaceContainerHighest.withOpacity(0.7),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: IslandColors.surfaceContainerHighest,
            offset: Offset(0, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.monetization_on,
            color: IslandColors.secondaryContainer,
            size: 18,
          ),
          const SizedBox(width: 4),
          Text(
            _formatCoins(coins),
            style: IslandTypography.labelMd(color: IslandColors.onSurface),
          ),
          if (onAddTap != null) ...[
            const SizedBox(width: 6),
            GestureDetector(
              onTap: onAddTap,
              child: Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: IslandColors.secondaryContainer,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: IslandColors.secondaryDark,
                      offset: Offset(0, 1.5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 12,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatCoins(int amount) {
    if (amount >= 1000) {
      final str = amount.toString();
      final buffer = StringBuffer();
      int count = 0;
      for (int i = str.length - 1; i >= 0; i--) {
        buffer.write(str[i]);
        count++;
        if (count % 3 == 0 && i > 0) {
          buffer.write(',');
        }
      }
      return buffer.toString().split('').reversed.join('');
    }
    return amount.toString();
  }
}
