import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:word_archipelago/domain/models/crossword_word.dart';
import 'package:word_archipelago/domain/models/puzzle_level.dart';

void main() {
  group('Crossword Interconnectivity & Anagram Integrity', () {
    for (int lvlNum = 1; lvlNum <= 5; lvlNum++) {
      test('Level $lvlNum must be 100% interconnected with no isolated words and valid anagrams', () {
        final level = PuzzleLevel.getLevel(lvlNum);

        // 1. Check wheel letter frequency
        final wheelCount = <String, int>{};
        for (final l in level.wheelLetters) {
          wheelCount[l] = (wheelCount[l] ?? 0) + 1;
        }

        for (final w in level.words) {
          final wordCount = <String, int>{};
          for (int i = 0; i < w.word.length; i++) {
            final ch = w.word[i];
            wordCount[ch] = (wordCount[ch] ?? 0) + 1;
            expect(
              wordCount[ch]! <= (wheelCount[ch] ?? 0),
              isTrue,
              reason: 'Level $lvlNum: Word "${w.word}" uses "$ch" ${wordCount[ch]} times, but wheel only has ${wheelCount[ch] ?? 0}',
            );
          }
        }

        for (final b in level.bonusWords) {
          final wordCount = <String, int>{};
          for (int i = 0; i < b.length; i++) {
            final ch = b[i];
            wordCount[ch] = (wordCount[ch] ?? 0) + 1;
            expect(
              wordCount[ch]! <= (wheelCount[ch] ?? 0),
              isTrue,
              reason: 'Level $lvlNum: Bonus word "$b" uses "$ch" ${wordCount[ch]} times, but wheel only has ${wheelCount[ch] ?? 0}',
            );
          }
        }

        // 2. Build grid map and check intersection integrity
        final grid = <Point<int>, String>{};
        final cellOwners = <Point<int>, List<CrosswordWord>>{};

        for (final w in level.words) {
          for (int i = 0; i < w.word.length; i++) {
            final c = w.cells[i];
            final pt = Point<int>(c.row, c.col);
            final ch = w.word[i];

            if (grid.containsKey(pt)) {
              expect(
                grid[pt],
                equals(ch),
                reason: 'Level $lvlNum: Intersection clash at (${c.row}, ${c.col}): existing "${grid[pt]}" vs incoming "$ch" in "${w.word}"',
              );
            } else {
              grid[pt] = ch;
            }
            cellOwners.putIfAbsent(pt, () => []).add(w);
          }
        }

        // 3. Check connectivity - MUST BE EXACTLY ONE CONNECTED GRAPH
        final visited = <CrosswordWord>{level.words.first};
        final queue = <CrosswordWord>[level.words.first];

        while (queue.isNotEmpty) {
          final curr = queue.removeAt(0);
          for (final c in curr.cells) {
            final pt = Point<int>(c.row, c.col);
            for (final neighbor in cellOwners[pt]!) {
              if (!visited.contains(neighbor)) {
                visited.add(neighbor);
                queue.add(neighbor);
              }
            }
          }
        }

        final unvisited = level.words.where((w) => !visited.contains(w)).map((w) => w.word).toList();
        expect(
          unvisited,
          isEmpty,
          reason: 'Level $lvlNum: Isolated/separated words found! These words are not connected to the main crossword: $unvisited',
        );

        // 4. Ensure no unwanted adjacent parallel touching
        for (final w in level.words) {
          final isAcross = w.direction == WordDirection.across;
          for (int i = 0; i < w.word.length; i++) {
            final c = w.cells[i];
            final pt = Point<int>(c.row, c.col);

            if (isAcross) {
              for (final adj in [Point<int>(pt.x - 1, pt.y), Point<int>(pt.x + 1, pt.y)]) {
                if (grid.containsKey(adj)) {
                  final hasPerpendicular = cellOwners[pt]!.any((o) => o.direction == WordDirection.down);
                  expect(
                    hasPerpendicular,
                    isTrue,
                    reason: 'Level $lvlNum: Unwanted parallel touch in across word "${w.word}" at (${pt.x}, ${pt.y}) touching (${adj.x}, ${adj.y})',
                  );
                }
              }
            } else {
              for (final adj in [Point<int>(pt.x, pt.y - 1), Point<int>(pt.x, pt.y + 1)]) {
                if (grid.containsKey(adj)) {
                  final hasPerpendicular = cellOwners[pt]!.any((o) => o.direction == WordDirection.across);
                  expect(
                    hasPerpendicular,
                    isTrue,
                    reason: 'Level $lvlNum: Unwanted parallel touch in down word "${w.word}" at (${pt.x}, ${pt.y}) touching (${adj.x}, ${adj.y})',
                  );
                }
              }
            }
          }
        }
      });
    }
  });
}
