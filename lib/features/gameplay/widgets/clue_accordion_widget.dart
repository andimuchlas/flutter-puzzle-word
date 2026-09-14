import 'package:flutter/material.dart';
import '../../../../core/theme/island_colors.dart';
import '../../../../core/theme/island_typography.dart';
import '../models/crossword_models.dart';

class ClueAccordionWidget extends StatefulWidget {
  final List<CrosswordWord> words;
  final CrosswordWord? activeWord;
  final ValueChanged<CrosswordWord> onSelectWord;

  const ClueAccordionWidget({
    super.key,
    required this.words,
    required this.activeWord,
    required this.onSelectWord,
  });

  @override
  State<ClueAccordionWidget> createState() => _ClueAccordionWidgetState();
}

class _ClueAccordionWidgetState extends State<ClueAccordionWidget> {
  WordDirection _selectedDirection = WordDirection.across;

  @override
  Widget build(BuildContext context) {
    final acrossWords =
        widget.words.where((w) => w.direction == WordDirection.across).toList();
    final downWords =
        widget.words.where((w) => w.direction == WordDirection.down).toList();

    final currentList =
        _selectedDirection == WordDirection.across ? acrossWords : downWords;
    final solvedCount = widget.words.where((w) => w.isSolved).length;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: IslandColors.outlineLight),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A0F172A),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header tabs (ACROSS / DOWN / Solved progress)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () =>
                        setState(() => _selectedDirection = WordDirection.across),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedDirection == WordDirection.across
                                ? IslandColors.primaryLight
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        'ACROSS (${acrossWords.length})',
                        style: IslandTypography.labelSm(
                          color: _selectedDirection == WordDirection.across
                              ? IslandColors.primaryLight
                              : IslandColors.onSurfaceVariant,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () =>
                        setState(() => _selectedDirection = WordDirection.down),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedDirection == WordDirection.down
                                ? IslandColors.primaryLight
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        'DOWN (${downWords.length})',
                        style: IslandTypography.labelSm(
                          color: _selectedDirection == WordDirection.down
                              ? IslandColors.primaryLight
                              : IslandColors.onSurfaceVariant,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 14,
                    color: IslandColors.gameGreen,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    '$solvedCount/${widget.words.length} Solved',
                    style: IslandTypography.labelSm(
                      color: IslandColors.gameGreen,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 4),

          // Clue List
          SizedBox(
            height: 52,
            child: ListView.builder(
              itemCount: currentList.length,
              itemBuilder: (context, idx) {
                final w = currentList[idx];
                final isActive = widget.activeWord?.id == w.id;

                return GestureDetector(
                  onTap: () => widget.onSelectWord(w),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isActive
                          ? IslandColors.cellActiveWord
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      border: isActive
                          ? Border.all(color: IslandColors.cellActiveWordBorder)
                          : null,
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${w.clueNumber}. ',
                          style: IslandTypography.labelSm(
                            color: isActive
                                ? IslandColors.primaryLight
                                : IslandColors.onSurfaceVariant,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Text(
                            w.clueText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: IslandTypography.bodySm(
                              color: IslandColors.onSurface,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          w.isSolved ? '${w.word} ✓' : '_ ' * w.word.length,
                          style: IslandTypography.labelSm(
                            color: w.isSolved
                                ? IslandColors.gameGreen
                                : IslandColors.outline,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
