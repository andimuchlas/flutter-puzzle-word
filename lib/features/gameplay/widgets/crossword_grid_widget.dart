import 'package:flutter/material.dart';
import '../../../../core/theme/island_typography.dart';
import '../../../../domain/models/cell_coord.dart';
import '../../../../domain/models/crossword_word.dart';
import '../../../../domain/models/puzzle_level.dart';

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
    final rows = level.dynamicRows;
    final cols = level.dynamicCols;

    const double cellSize = 46.0;
    const double spacing = 4.0;
    const double padding = 8.0;
    final double gridWidth = cols * cellSize + (cols - 1) * spacing + padding * 2;
    final double gridHeight = rows * cellSize + (rows - 1) * spacing + padding * 2;

    return SizedBox(
      width: gridWidth,
      height: gridHeight,
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: rows * cols,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemBuilder: (context, index) {
            final r = index ~/ cols;
            final c = index % cols;
            return _buildCell(r, c);
          },
        ),
      ),
    );
  }

  Widget _buildCell(int r, int c) {
    final coord = CellCoord(r, c);

    // Find all words using this cell
    final matchingWords =
        level.words.where((w) => w.cells.contains(coord)).toList();

    // Cell is empty/unused in Wordscapes -> completely transparent
    if (matchingWords.isEmpty) {
      return const SizedBox.shrink();
    }

    // Determine primary matching word (prefer activeWord if it intersects this cell)
    CrosswordWord matchingWord = matchingWords.first;
    if (activeWord != null && matchingWords.contains(activeWord)) {
      matchingWord = activeWord!;
    }

    // Check if cell is solved
    bool isCellSolved = false;
    String displayLetter = '';

    for (final word in matchingWords) {
      final idx = word.cells.indexOf(coord);
      if (idx != -1 && word.isSolved) {
        isCellSolved = true;
        displayLetter = word.word[idx];
        break;
      }
    }

    final isNewlySolved = matchingWords.any((w) => w.id == newlySolvedWordId);

    return GestureDetector(
      onTap: () {
        if (onWordSelected != null) {
          if (matchingWords.length > 1 && matchingWords.contains(activeWord)) {
            final otherWord = matchingWords.firstWhere((w) => w != activeWord);
            onWordSelected!(otherWord);
          } else {
            onWordSelected!(matchingWord);
          }
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        transform: isNewlySolved
            ? Matrix4.diagonal3Values(1.08, 1.08, 1.0)
            : Matrix4.identity(),
        decoration: isCellSolved
            ? BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF6366F1), // Indigo 500
                    Color(0xFF4338CA), // Indigo 700
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x35000000),
                    offset: Offset(0, 3),
                    blurRadius: 5,
                  ),
                ],
              )
            : BoxDecoration(
                color: Colors.white.withOpacity(0.20),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.white.withOpacity(0.65),
                  width: 1.5,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
        child: Center(
          child: isCellSolved
              ? Text(
                  displayLetter,
                  style: IslandTypography.displayLg(
                    color: Colors.white,
                  ).copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
