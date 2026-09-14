import 'package:flutter_test/flutter_test.dart';
import 'package:word_archipelago/domain/models/cell_coord.dart';
import 'package:word_archipelago/domain/models/crossword_word.dart';
import 'package:word_archipelago/domain/models/puzzle_level.dart';

void main() {
  group('CrosswordModels & 5 Dynamic Levels Test', () {
    test('All 5 levels initialization and dynamic grid calculations', () {
      final allLevels = PuzzleLevel.getAllLevels();
      expect(allLevels.length, 5);

      for (int i = 0; i < allLevels.length; i++) {
        final level = allLevels[i];
        expect(level.levelNumber, i + 1);
        expect(level.words.isNotEmpty, isTrue);
        expect(level.dynamicRows, greaterThanOrEqualTo(4));
        expect(level.dynamicCols, greaterThanOrEqualTo(4));
        expect(level.aspectRatio, greaterThan(0));
        expect(level.wheelLetters.isNotEmpty, isTrue);
      }
    });

    test('Mathematical verification of intersecting words across all 5 levels', () {
      final allLevels = PuzzleLevel.getAllLevels();

      for (final level in allLevels) {
        // Collect all cells and their letter mappings
        final cellMap = <CellCoord, String>{};

        for (final word in level.words) {
          expect(word.cells.length, word.word.length,
              reason: 'Word ${word.word} length must match its cells count in Level ${level.levelNumber}');

          for (int idx = 0; idx < word.cells.length; idx++) {
            final coord = word.cells[idx];
            final letter = word.word[idx];

            if (cellMap.containsKey(coord)) {
              expect(cellMap[coord], letter,
                  reason: 'Intersection conflict at $coord in Level ${level.levelNumber}: '
                      'existing "${cellMap[coord]}" vs word ${word.word} "$letter"');
            } else {
              cellMap[coord] = letter;
            }
          }
        }
      }
    });

    test('Cell coordinate equality and hashcode', () {
      const c1 = CellCoord(2, 3);
      const c2 = CellCoord(2, 3);
      const c3 = CellCoord(3, 2);

      expect(c1 == c2, isTrue);
      expect(c1 == c3, isFalse);
      expect(c1.hashCode, c2.hashCode);
    });

    test('Bilingual clue resolution and direction tags', () {
      final w = CrosswordWord(
        id: 'test_across',
        word: 'BEACH',
        direction: WordDirection.across,
        clueNumber: 3,
        clueTextEn: 'Sandy tropical shore',
        clueTextId: 'Pesisir pantai tropis yang berpasir',
        cells: const [
          CellCoord(0, 0),
          CellCoord(0, 1),
          CellCoord(0, 2),
          CellCoord(0, 3),
          CellCoord(0, 4),
        ],
      );

      expect(w.directionTag('en'), '3 ACROSS');
      expect(w.directionTag('id'), '3 MENDATAR');
      expect(w.lengthTag('en'), '5 letters');
      expect(w.lengthTag('id'), '5 huruf');
      expect(w.getClue('en'), 'Sandy tropical shore');
      expect(w.getClue('id'), 'Pesisir pantai tropis yang berpasir');
    });
  });
}
