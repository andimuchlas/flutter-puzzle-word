import 'cell_coord.dart';
import 'crossword_word.dart';

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

  /// Dynamic calculation of bounding rows from actual word cells
  int get dynamicRows {
    if (words.isEmpty) return rows;
    int maxR = 0;
    for (final w in words) {
      for (final c in w.cells) {
        if (c.row > maxR) maxR = c.row;
      }
    }
    return maxR + 1;
  }

  /// Dynamic calculation of bounding columns from actual word cells
  int get dynamicCols {
    if (words.isEmpty) return cols;
    int maxC = 0;
    for (final w in words) {
      for (final c in w.cells) {
        if (c.col > maxC) maxC = c.col;
      }
    }
    return maxC + 1;
  }

  /// Dynamic aspect ratio for layout constraints
  double get aspectRatio => dynamicCols / dynamicRows;

  /// Clone level with a fresh unsolved state
  PuzzleLevel copyFresh() {
    return PuzzleLevel(
      levelNumber: levelNumber,
      islandNumber: islandNumber,
      islandName: islandName,
      rows: dynamicRows,
      cols: dynamicCols,
      words: words.map((w) => w.copyWith(isSolved: false)).toList(),
      wheelLetters: List.from(wheelLetters),
      bonusWords: List.from(bonusWords),
    );
  }

  // =========================================================================
  // MOCK DATA: 5 COMPLETE PLAYABLE LEVELS BERTEMA NUSANTARA
  // All intersections mathematically checked and verified!
  // =========================================================================

  /// Level 1 — Pesisir Bali (6x6 grid)
  /// Anagram Root: PANTAI
  /// Wheel: ['P', 'A', 'N', 'T', 'A', 'I']
  /// Intersections:
  /// - (0,0): PANTAI (0,0)='P' and PITA (0,0)='P'
  /// - (2,0): PITA (2,0)='T' and TANI (2,0)='T'
  /// - (2,2): TANI (2,2)='N' and NAPI (2,2)='N'
  static PuzzleLevel getLevel1() {
    final words = [
      CrosswordWord(
        id: '1_1_across',
        word: 'PANTAI',
        direction: WordDirection.across,
        clueNumber: 1,
        clueTextEn: 'Beach',
        clueTextId: 'Pantai',
        cells: const [
          CellCoord(0, 0),
          CellCoord(0, 1),
          CellCoord(0, 2),
          CellCoord(0, 3),
          CellCoord(0, 4),
          CellCoord(0, 5),
        ],
      ),
      CrosswordWord(
        id: '1_1_down',
        word: 'PITA',
        direction: WordDirection.down,
        clueNumber: 1,
        clueTextEn: 'Ribbon',
        clueTextId: 'Pita',
        cells: const [
          CellCoord(0, 0),
          CellCoord(1, 0),
          CellCoord(2, 0),
          CellCoord(3, 0),
        ],
      ),
      CrosswordWord(
        id: '1_2_across',
        word: 'TANI',
        direction: WordDirection.across,
        clueNumber: 2,
        clueTextEn: 'Farm',
        clueTextId: 'Tani',
        cells: const [
          CellCoord(2, 0),
          CellCoord(2, 1),
          CellCoord(2, 2),
          CellCoord(2, 3),
        ],
      ),
      CrosswordWord(
        id: '1_2_down',
        word: 'NAPI',
        direction: WordDirection.down,
        clueNumber: 2,
        clueTextEn: 'Inmate',
        clueTextId: 'Napi',
        cells: const [
          CellCoord(2, 2),
          CellCoord(3, 2),
          CellCoord(4, 2),
          CellCoord(5, 2),
        ],
      ),
    ];

    return PuzzleLevel(
      levelNumber: 1,
      islandNumber: 1,
      islandName: 'Pesisir Bali',
      rows: 6,
      cols: 6,
      words: words,
      wheelLetters: ['P', 'A', 'N', 'T', 'A', 'I'],
      bonusWords: ['PATI', 'TAPA', 'ATAP', 'APIT', 'NITA', 'TIPA'],
    );
  }

  /// Level 2 — Kepulauan Rempah (7x6 grid)
  /// Anagram Root: REMPAH
  /// Wheel: ['R', 'E', 'M', 'P', 'A', 'H']
  /// Intersections:
  /// - (0,0): PARE (0,0)='P' and PERAH (0,0)='P'
  /// - (2,0): PERAH (2,0)='R' and REMPAH (2,0)='R'
  /// - (2,2): REMPAH (2,2)='M' and MERAH (2,2)='M'
  static PuzzleLevel getLevel2() {
    final words = [
      CrosswordWord(
        id: '2_1_across',
        word: 'PARE',
        direction: WordDirection.across,
        clueNumber: 1,
        clueTextEn: 'Bitter melon',
        clueTextId: 'Pare',
        cells: const [
          CellCoord(0, 0),
          CellCoord(0, 1),
          CellCoord(0, 2),
          CellCoord(0, 3),
        ],
      ),
      CrosswordWord(
        id: '2_1_down',
        word: 'PERAH',
        direction: WordDirection.down,
        clueNumber: 1,
        clueTextEn: 'Squeeze / Milking',
        clueTextId: 'Perah',
        cells: const [
          CellCoord(0, 0),
          CellCoord(1, 0),
          CellCoord(2, 0),
          CellCoord(3, 0),
          CellCoord(4, 0),
        ],
      ),
      CrosswordWord(
        id: '2_2_across',
        word: 'REMPAH',
        direction: WordDirection.across,
        clueNumber: 2,
        clueTextEn: 'Spices',
        clueTextId: 'Rempah',
        cells: const [
          CellCoord(2, 0),
          CellCoord(2, 1),
          CellCoord(2, 2),
          CellCoord(2, 3),
          CellCoord(2, 4),
          CellCoord(2, 5),
        ],
      ),
      CrosswordWord(
        id: '2_2_down',
        word: 'MERAH',
        direction: WordDirection.down,
        clueNumber: 2,
        clueTextEn: 'Red',
        clueTextId: 'Merah',
        cells: const [
          CellCoord(2, 2),
          CellCoord(3, 2),
          CellCoord(4, 2),
          CellCoord(5, 2),
          CellCoord(6, 2),
        ],
      ),
    ];

    return PuzzleLevel(
      levelNumber: 2,
      islandNumber: 1,
      islandName: 'Kepulauan Rempah',
      rows: 7,
      cols: 6,
      words: words,
      wheelLetters: ['R', 'E', 'M', 'P', 'A', 'H'],
      bonusWords: ['APEM', 'RAME', 'PERA', 'HAP', 'ERA', 'REPA'],
    );
  }

  /// Level 3 — Lembah Candi (6x8 grid)
  /// Anagram Root: CANDIK
  /// Wheel: ['C', 'A', 'N', 'D', 'I', 'K']
  /// Intersections:
  /// - (0,2): CANDI (0,2)='N' and NAIK (0,2)='N'
  /// - (0,4): CANDI (0,4)='I' and IKAN (0,4)='I'
  /// - (2,4): IKAN (2,4)='A' and ADIK (2,4)='A'
  /// - (2,7): ADIK (2,7)='K' and KINA (2,7)='K'
  static PuzzleLevel getLevel3() {
    final words = [
      CrosswordWord(
        id: '3_1_across',
        word: 'CANDI',
        direction: WordDirection.across,
        clueNumber: 1,
        clueTextEn: 'Temple monument',
        clueTextId: 'Candi',
        cells: const [
          CellCoord(0, 0),
          CellCoord(0, 1),
          CellCoord(0, 2),
          CellCoord(0, 3),
          CellCoord(0, 4),
        ],
      ),
      CrosswordWord(
        id: '3_1_down',
        word: 'NAIK',
        direction: WordDirection.down,
        clueNumber: 1,
        clueTextEn: 'Go up / Climb',
        clueTextId: 'Naik',
        cells: const [
          CellCoord(0, 2),
          CellCoord(1, 2),
          CellCoord(2, 2),
          CellCoord(3, 2),
        ],
      ),
      CrosswordWord(
        id: '3_2_down',
        word: 'IKAN',
        direction: WordDirection.down,
        clueNumber: 2,
        clueTextEn: 'Fish',
        clueTextId: 'Ikan',
        cells: const [
          CellCoord(0, 4),
          CellCoord(1, 4),
          CellCoord(2, 4),
          CellCoord(3, 4),
        ],
      ),
      CrosswordWord(
        id: '3_2_across',
        word: 'ADIK',
        direction: WordDirection.across,
        clueNumber: 2,
        clueTextEn: 'Younger sibling',
        clueTextId: 'Adik',
        cells: const [
          CellCoord(2, 4),
          CellCoord(2, 5),
          CellCoord(2, 6),
          CellCoord(2, 7),
        ],
      ),
      CrosswordWord(
        id: '3_3_down',
        word: 'KINA',
        direction: WordDirection.down,
        clueNumber: 3,
        clueTextEn: 'Quinine herbal bark',
        clueTextId: 'Kina',
        cells: const [
          CellCoord(2, 7),
          CellCoord(3, 7),
          CellCoord(4, 7),
          CellCoord(5, 7),
        ],
      ),
    ];

    return PuzzleLevel(
      levelNumber: 3,
      islandNumber: 1,
      islandName: 'Lembah Candi',
      rows: 6,
      cols: 8,
      words: words,
      wheelLetters: ['C', 'A', 'N', 'D', 'I', 'K'],
      bonusWords: ['KIAN', 'DINA', 'DAN', 'AKI', 'KAI'],
    );
  }

  /// Level 4 — Rimba Borneo (7x5 grid)
  /// Anagram Root: RIMBAN
  /// Wheel: ['R', 'I', 'M', 'B', 'A', 'N']
  /// Intersections:
  /// - (1,1): BANI (1,1)='A' and NABI (1,1)='A'
  /// - (3,1): NABI (3,1)='I' and RIMBA (3,1)='I'
  /// - (3,2): RIMBA (3,2)='M' and MAIN (3,2)='M'
  /// - (5,2): MAIN (5,2)='I' and BINA (5,2)='I'
  static PuzzleLevel getLevel4() {
    final words = [
      CrosswordWord(
        id: '4_1_across',
        word: 'BANI',
        direction: WordDirection.across,
        clueNumber: 1,
        clueTextEn: 'Offspring / Tribe',
        clueTextId: 'Bani',
        cells: const [
          CellCoord(1, 0),
          CellCoord(1, 1),
          CellCoord(1, 2),
          CellCoord(1, 3),
        ],
      ),
      CrosswordWord(
        id: '4_1_down',
        word: 'NABI',
        direction: WordDirection.down,
        clueNumber: 1,
        clueTextEn: 'Prophet',
        clueTextId: 'Nabi',
        cells: const [
          CellCoord(0, 1),
          CellCoord(1, 1),
          CellCoord(2, 1),
          CellCoord(3, 1),
        ],
      ),
      CrosswordWord(
        id: '4_2_across',
        word: 'RIMBA',
        direction: WordDirection.across,
        clueNumber: 2,
        clueTextEn: 'Jungle / Forest',
        clueTextId: 'Rimba',
        cells: const [
          CellCoord(3, 0),
          CellCoord(3, 1),
          CellCoord(3, 2),
          CellCoord(3, 3),
          CellCoord(3, 4),
        ],
      ),
      CrosswordWord(
        id: '4_2_down',
        word: 'MAIN',
        direction: WordDirection.down,
        clueNumber: 2,
        clueTextEn: 'Play',
        clueTextId: 'Main',
        cells: const [
          CellCoord(3, 2),
          CellCoord(4, 2),
          CellCoord(5, 2),
          CellCoord(6, 2),
        ],
      ),
      CrosswordWord(
        id: '4_3_across',
        word: 'BINA',
        direction: WordDirection.across,
        clueNumber: 3,
        clueTextEn: 'Build / Foster',
        clueTextId: 'Bina',
        cells: const [
          CellCoord(5, 1),
          CellCoord(5, 2),
          CellCoord(5, 3),
          CellCoord(5, 4),
        ],
      ),
    ];

    return PuzzleLevel(
      levelNumber: 4,
      islandNumber: 1,
      islandName: 'Rimba Borneo',
      rows: 7,
      cols: 5,
      words: words,
      wheelLetters: ['R', 'I', 'M', 'B', 'A', 'N'],
      bonusWords: ['MARI', 'RANI', 'BIMA', 'AIR', 'BIA', 'NIRA'],
    );
  }

  /// Level 5 — Pesona Raja Ampat (7x6 grid)
  /// Anagram Root: PESONA
  /// Wheel: ['P', 'E', 'S', 'O', 'N', 'A']
  /// Intersections:
  /// - (2,0): PESONA (2,0)='P' and PESAN (2,0)='P'
  /// - (2,2): PESONA (2,2)='S' and SENA (2,2)='S'
  /// - (2,4): PESONA (2,4)='N' and PENA (2,4)='N'
  static PuzzleLevel getLevel5() {
    final words = [
      CrosswordWord(
        id: '5_1_across',
        word: 'PESONA',
        direction: WordDirection.across,
        clueNumber: 1,
        clueTextEn: 'Charm / Beauty',
        clueTextId: 'Pesona',
        cells: const [
          CellCoord(2, 0),
          CellCoord(2, 1),
          CellCoord(2, 2),
          CellCoord(2, 3),
          CellCoord(2, 4),
          CellCoord(2, 5),
        ],
      ),
      CrosswordWord(
        id: '5_1_down',
        word: 'PESAN',
        direction: WordDirection.down,
        clueNumber: 1,
        clueTextEn: 'Message / Order',
        clueTextId: 'Pesan',
        cells: const [
          CellCoord(2, 0),
          CellCoord(3, 0),
          CellCoord(4, 0),
          CellCoord(5, 0),
          CellCoord(6, 0),
        ],
      ),
      CrosswordWord(
        id: '5_2_down',
        word: 'SENA',
        direction: WordDirection.down,
        clueNumber: 2,
        clueTextEn: 'Troops / Hero',
        clueTextId: 'Sena',
        cells: const [
          CellCoord(2, 2),
          CellCoord(3, 2),
          CellCoord(4, 2),
          CellCoord(5, 2),
        ],
      ),
      CrosswordWord(
        id: '5_3_down',
        word: 'PENA',
        direction: WordDirection.down,
        clueNumber: 3,
        clueTextEn: 'Pen / Quill',
        clueTextId: 'Pena',
        cells: const [
          CellCoord(0, 4),
          CellCoord(1, 4),
          CellCoord(2, 4),
          CellCoord(3, 4),
        ],
      ),
    ];

    return PuzzleLevel(
      levelNumber: 5,
      islandNumber: 1,
      islandName: 'Pesona Raja Ampat',
      rows: 7,
      cols: 6,
      words: words,
      wheelLetters: ['P', 'E', 'S', 'O', 'N', 'A'],
      bonusWords: ['POS', 'PAS', 'SAPO', 'APEN', 'SOPA'],
    );
  }

  /// Get level by index (1 to 5)
  static PuzzleLevel getLevel(int levelNumber) {
    switch (levelNumber) {
      case 1:
        return getLevel1();
      case 2:
        return getLevel2();
      case 3:
        return getLevel3();
      case 4:
        return getLevel4();
      case 5:
        return getLevel5();
      default:
        return getLevel1();
    }
  }

  /// Get total available mock levels
  static List<PuzzleLevel> getAllLevels() {
    return [
      getLevel1(),
      getLevel2(),
      getLevel3(),
      getLevel4(),
      getLevel5(),
    ];
  }
}
