import 'package:flutter/material.dart';
import '../../../../core/theme/island_colors.dart';
import '../../../../core/theme/island_typography.dart';
import '../models/crossword_models.dart';

class CrosswordGridWidget extends StatelessWidget {
  final PuzzleLevel level;
  final CrosswordWord? activeWord;
  final ValueChanged<CrosswordWord>? onWordSelected;
  final String? newlySolvedWordId;

  const CrosswordGridWidget({
    super.key,
    required this.level,
    this.activeWord,
    this.onWordSelected,
    this.newlySolvedWordId,
  });

  @override
  Widget build(BuildContext context) {
    // Determine cell contents and statuses
    final rows = level.rows;
    final cols = level.cols;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 340),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xE8CBD5E1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: IslandColors.outlineVariant.withOpacity(0.8),
            width: 1.5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x180F172A),
              offset: Offset(0, 2),
              blurRadius: 6,
              spreadRadius: 0,
            ),
          ],
        ),
        child: AspectRatio(
          aspectRatio: cols / rows,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: rows * cols,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              final r = index ~/ cols;
              final c = index % cols;
              return _buildCell(r, c);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCell(int r, int c) {
    final coord = CellCoord(r, c);

    // Find if any word uses this cell
    CrosswordWord? matchingWord;
    int? clueNumber;

    for (final word in level.words) {
      final idx = word.cells.indexOf(coord);
      if (idx != -1) {
        matchingWord ??= word;
        if (idx == 0) {
          clueNumber = word.clueNumber;
        }
      }
    }

    // Cell is blocked/empty in the crossword grid
    if (matchingWord == null) {
      return Container(
        decoration: BoxDecoration(
          color: IslandColors.cellBlocked.withOpacity(0.6),
          borderRadius: BorderRadius.circular(8),
        ),
      );
    }

    // Check if cell is solved
    bool isCellSolved = false;
    String displayLetter = '';

    for (final word in level.words) {
      final idx = word.cells.indexOf(coord);
      if (idx != -1 && word.isSolved) {
        isCellSolved = true;
        displayLetter = word.word[idx];
        break;
      }
    }

    // Check if in active word
    final isInActiveWord = activeWord != null && activeWord!.cells.contains(coord);
    final isWordFirstCell = activeWord != null &&
        activeWord!.cells.isNotEmpty &&
        activeWord!.cells.first == coord;

    final isNewlySolved = matchingWord.id == newlySolvedWordId;

    return GestureDetector(
      onTap: () {
        if (onWordSelected != null) {
          onWordSelected!(matchingWord!);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        transform: isNewlySolved ? Matrix4.diagonal3Values(1.05, 1.05, 1.0) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: isCellSolved
              ? Colors.white
              : (isInActiveWord ? IslandColors.cellActiveWord : Colors.white),
          borderRadius: BorderRadius.circular(8),
          border: isWordFirstCell
              ? Border.all(color: IslandColors.primaryLight, width: 2.5)
              : (isInActiveWord
                  ? Border.all(color: IslandColors.cellActiveWordBorder, width: 1.5)
                  : Border.all(color: IslandColors.outlineLight, width: 1)),
          boxShadow: [
            BoxShadow(
              color: isWordFirstCell
                  ? IslandColors.primaryLight.withOpacity(0.3)
                  : const Color(0x100F172A),
              offset: const Offset(0, 2),
              blurRadius: 2,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Clue number in top-left
            if (clueNumber != null)
              Positioned(
                top: 2,
                left: 3,
                child: Text(
                  clueNumber.toString(),
                  style: IslandTypography.labelSm(
                    color: IslandColors.onSurfaceVariant,
                  ).copyWith(fontSize: 8.5, fontWeight: FontWeight.bold),
                ),
              ),

            // Letter content
            if (isCellSolved)
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: IslandTypography.titleTile(
                  color: isNewlySolved
                      ? IslandColors.gameGreen
                      : (isWordFirstCell
                          ? IslandColors.primaryLight
                          : IslandColors.onSurface),
                ).copyWith(fontSize: 20),
                child: Text(displayLetter),
              )
            else if (isInActiveWord)
              Container(
                width: 10,
                height: 3,
                decoration: BoxDecoration(
                  color: IslandColors.primaryLight.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
