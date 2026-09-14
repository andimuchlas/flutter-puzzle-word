enum WordDirection { across, down }

class CellCoord {
  final int row;
  final int col;

  const CellCoord(this.row, this.col);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CellCoord &&
          runtimeType == other.runtimeType &&
          row == other.row &&
          col == other.col;

  @override
  int get hashCode => row.hashCode ^ col.hashCode;
}

class CrosswordWord {
  final String id;
  final String word;
  final WordDirection direction;
  final int clueNumber;
  final String clueText;
  final List<CellCoord> cells;
  bool isSolved;

  CrosswordWord({
    required this.id,
    required this.word,
    required this.direction,
    required this.clueNumber,
    required this.clueText,
    required this.cells,
    this.isSolved = false,
  });

  String get directionTag =>
      direction == WordDirection.across ? '$clueNumber ACROSS' : '$clueNumber DOWN';
  String get lengthTag => '${word.length} letters';
}

class PuzzleLevel {
  final int levelNumber;
  final int islandNumber;
  final String islandName;
  final int rows;
  final int cols;
  final List<CrosswordWord> words;
  final List<String> wheelLetters;
  final List<String> bonusWords;

  PuzzleLevel({
    required this.levelNumber,
    required this.islandNumber,
    required this.islandName,
    required this.rows,
    required this.cols,
    required this.words,
    required this.wheelLetters,
    this.bonusWords = const [],
  });

  /// Generate sample Level 12 from Stitch "Tropical Coast" screen
  static PuzzleLevel getSampleLevel12() {
    // 6x6 grid layout
    // Words:
    // 1 ACROSS: MANGO at (0,0)-(0,4)
    // 1 DOWN: MAP at (0,0)-(2,0)
    // 2 DOWN: ATOLL at (0,1)-(4,1) (uses A from MANGO)
    // 4 ACROSS: OCEAN at (2,1)-(2,5) (uses O from ATOLL)
    // 6 ACROSS: PALM at (4,1)-(4,4) (uses L from ATOLL)
    final words = [
      CrosswordWord(
        id: '1_across',
        word: 'MANGO',
        direction: WordDirection.across,
        clueNumber: 1,
        clueText: 'A tropical fruit with orange flesh',
        cells: [
          const CellCoord(0, 0),
          const CellCoord(0, 1),
          const CellCoord(0, 2),
          const CellCoord(0, 3),
          const CellCoord(0, 4),
        ],
        isSolved: true, // Initially solved in sample to match Stitch preview
      ),
      CrosswordWord(
        id: '1_down',
        word: 'MAP',
        direction: WordDirection.down,
        clueNumber: 1,
        clueText: 'Navigation guide across the sea',
        cells: [
          const CellCoord(0, 0),
          const CellCoord(1, 0),
          const CellCoord(2, 0),
        ],
        isSolved: true,
      ),
      CrosswordWord(
        id: '2_down',
        word: 'ATOLL',
        direction: WordDirection.down,
        clueNumber: 2,
        clueText: 'Small ring-shaped coral reef island',
        cells: [
          const CellCoord(0, 1),
          const CellCoord(1, 1),
          const CellCoord(2, 1),
          const CellCoord(3, 1),
          const CellCoord(4, 1),
        ],
        isSolved: false,
      ),
      CrosswordWord(
        id: '4_across',
        word: 'OCEAN',
        direction: WordDirection.across,
        clueNumber: 4,
        clueText: 'A vast expanse of salt water',
        cells: [
          const CellCoord(2, 1),
          const CellCoord(2, 2),
          const CellCoord(2, 3),
          const CellCoord(2, 4),
          const CellCoord(2, 5),
        ],
        isSolved: true,
      ),
      CrosswordWord(
        id: '6_across',
        word: 'PALM',
        direction: WordDirection.across,
        clueNumber: 6,
        clueText: 'Coastal tree that bears coconuts',
        cells: [
          const CellCoord(4, 1),
          const CellCoord(4, 2),
          const CellCoord(4, 3),
          const CellCoord(4, 4),
        ],
        isSolved: false,
      ),
    ];

    return PuzzleLevel(
      levelNumber: 12,
      islandNumber: 1,
      islandName: 'Tropical Coast',
      rows: 6,
      cols: 6,
      words: words,
      wheelLetters: ['M', 'A', 'N', 'G', 'O', 'P', 'L', 'T'],
      bonusWords: ['PAN', 'GAP', 'TOP', 'LOG', 'POT', 'MAT', 'TAG'],
    );
  }
}
