import 'package:flutter/material.dart';
import '../../../../core/theme/island_colors.dart';
import '../../../../core/theme/island_typography.dart';
import '../../../../domain/models/crossword_word.dart';

class ActiveClueBanner extends StatelessWidget {
  final CrosswordWord activeWord;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const ActiveClueBanner({
    super.key,
    required this.activeWord,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [IslandColors.primary, IslandColors.primaryContainer],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: IslandColors.primaryDark.withOpacity(0.5),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18006194),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          // Previous button
          GestureDetector(
            onTap: onPrevious,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Clue Content
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.22),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        activeWord.directionTag(locale),
                        style: IslandTypography.labelSm(color: Colors.white)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      activeWord.lengthTag(locale),
                      style: IslandTypography.bodySm(
                        color: IslandColors.primaryFixed,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  '"${activeWord.getClue(locale)}"',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: IslandTypography.bodyMd(color: Colors.white)
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Next button
          GestureDetector(
            onTap: onNext,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
