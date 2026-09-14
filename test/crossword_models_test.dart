import 'package:flutter_test/flutter_test.dart';
import 'package:word_archipelago/features/gameplay/models/crossword_models.dart';

void main() {
  group('CrosswordModels & PuzzleLevel Test', () {
    test('Level 12 sample initialization', () {
      final level = PuzzleLevel.getSampleLevel12();

      expect(level.levelNumber, 12);
      expect(level.islandName, 'Tropical Coast');
      expect(level.rows, 6);
      expect(level.cols, 6);
      expect(level.words.length, 5);
      expect(level.wheelLetters.contains('M'), isTrue);
      expect(level.wheelLetters.contains('A'), isTrue);
      expect(level.bonusWords.contains('PAN'), isTrue);
    });

    test('Cell coordinate equality', () {
      const c1 = CellCoord(2, 3);
      const c2 = CellCoord(2, 3);
      const c3 = CellCoord(3, 2);

      expect(c1 == c2, isTrue);
      expect(c1 == c3, isFalse);
    });

    test('Word direction tags', () {
      final w = CrosswordWord(
        id: 'test_across',
        word: 'BEACH',
        direction: WordDirection.across,
        clueNumber: 3,
        clueText: 'Sandy shore',
        cells: [
          const CellCoord(0, 0),
          const CellCoord(0, 1),
          const CellCoord(0, 2),
          const CellCoord(0, 3),
          const CellCoord(0, 4),
        ],
      );

      expect(w.directionTag, '3 ACROSS');
      expect(w.lengthTag, '5 letters');
    });
  });
}
