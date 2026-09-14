import 'cell_coord.dart';

enum WordDirection { across, down }

class CrosswordWord {
  final String id;
  final String word;
  final WordDirection direction;
  final int clueNumber;
  final String clueTextEn;
  final String clueTextId;
  final List<CellCoord> cells;
  bool isSolved;

  CrosswordWord({
    required this.id,
    required this.word,
    required this.direction,
    required this.clueNumber,
    required this.clueTextEn,
    required this.clueTextId,
    required this.cells,
    this.isSolved = false,
  });

  String getClue(String localeCode) {
    if (localeCode.toLowerCase().startsWith('id')) {
      return clueTextId.isNotEmpty ? clueTextId : clueTextEn;
    }
    return clueTextEn;
  }

  String directionTag(String localeCode) {
    final isId = localeCode.toLowerCase().startsWith('id');
    if (direction == WordDirection.across) {
      return isId ? '$clueNumber MENDATAR' : '$clueNumber ACROSS';
    } else {
      return isId ? '$clueNumber MENURUN' : '$clueNumber DOWN';
    }
  }

  String lengthTag(String localeCode) {
    final isId = localeCode.toLowerCase().startsWith('id');
    return isId ? '${word.length} huruf' : '${word.length} letters';
  }

  CrosswordWord copyWith({
    String? id,
    String? word,
    WordDirection? direction,
    int? clueNumber,
    String? clueTextEn,
    String? clueTextId,
    List<CellCoord>? cells,
    bool? isSolved,
  }) {
    return CrosswordWord(
      id: id ?? this.id,
      word: word ?? this.word,
      direction: direction ?? this.direction,
      clueNumber: clueNumber ?? this.clueNumber,
      clueTextEn: clueTextEn ?? this.clueTextEn,
      clueTextId: clueTextId ?? this.clueTextId,
      cells: cells ?? List.from(this.cells),
      isSolved: isSolved ?? this.isSolved,
    );
  }
}
