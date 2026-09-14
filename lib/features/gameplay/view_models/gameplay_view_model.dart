import 'dart:async';
import 'package:flutter/material.dart';
import 'package:word_archipelago/data/repositories/game_repository.dart';
import 'package:word_archipelago/domain/models/crossword_word.dart';
import 'package:word_archipelago/domain/models/puzzle_level.dart';

class GameplayViewModel extends ChangeNotifier {
  final GameRepository repository;
  late PuzzleLevel _level;
  int _activeWordIndex = 0;
  String? _newlySolvedWordId;
  String? _toastMessage;
  IconData? _toastIcon;
  bool _isLevelComplete = false;

  Timer? _toastTimer;
  Timer? _solveTimer;

  GameplayViewModel({
    required PuzzleLevel level,
    required this.repository,
  }) {
    _level = level.copyFresh();
    _selectFirstUnsolvedWord();
  }

  PuzzleLevel get level => _level;
  int get activeWordIndex => _activeWordIndex;
  CrosswordWord get activeWord => _level.words[_activeWordIndex];
  String? get newlySolvedWordId => _newlySolvedWordId;
  String? get toastMessage => _toastMessage;
  IconData? get toastIcon => _toastIcon;
  bool get isLevelComplete => _isLevelComplete;

  @override
  void dispose() {
    _toastTimer?.cancel();
    _solveTimer?.cancel();
    super.dispose();
  }

  void _selectFirstUnsolvedWord() {
    for (int i = 0; i < _level.words.length; i++) {
      if (!_level.words[i].isSolved) {
        _activeWordIndex = i;
        notifyListeners();
        return;
      }
    }
  }

  void selectWord(CrosswordWord word) {
    final idx = _level.words.indexOf(word);
    if (idx != -1 && idx != _activeWordIndex) {
      _activeWordIndex = idx;
      notifyListeners();
    }
  }

  void nextClue() {
    _activeWordIndex = (_activeWordIndex + 1) % _level.words.length;
    notifyListeners();
  }

  void prevClue() {
    _activeWordIndex = (_activeWordIndex - 1 + _level.words.length) % _level.words.length;
    notifyListeners();
  }

  void showToast(String message, [IconData? icon]) {
    _toastTimer?.cancel();
    _toastMessage = message;
    _toastIcon = icon;
    notifyListeners();

    _toastTimer = Timer(const Duration(milliseconds: 1600), () {
      _toastMessage = null;
      _toastIcon = null;
      if (hasListeners) {
        notifyListeners();
      }
    });
  }

  bool handleWordSubmitted(String submittedWord, {
    required String Function(String word) onSolvedMsg,
    required String Function(String word) onAlreadySolvedMsg,
    required String Function(String word, int coins) onBonusWordMsg,
    required String notInPuzzleMsg,
  }) {
    final wordUpper = submittedWord.trim().toUpperCase();

    // 1. Check if word matches any crossword word in this level
    CrosswordWord? matchedWord;
    for (final w in _level.words) {
      if (w.word == wordUpper) {
        if (w.isSolved) {
          showToast(onAlreadySolvedMsg(wordUpper), Icons.info_outline);
          return false;
        } else {
          matchedWord = w;
          break;
        }
      }
    }

    if (matchedWord != null) {
      matchedWord.isSolved = true;
      _newlySolvedWordId = matchedWord.id;
      showToast(onSolvedMsg(matchedWord.word), Icons.check_circle);
      notifyListeners();

      // Check if all words solved
      final allSolved = _level.words.every((w) => w.isSolved);
      if (allSolved) {
        _isLevelComplete = true;
        repository.completeLevel(_level.levelNumber, 3, 25);
        notifyListeners();
      } else {
        _selectFirstUnsolvedWord();
      }

      _triggerNewlySolved(matchedWord.id);
      return true;
    }

    // 2. Check bonus words
    if (_level.bonusWords.contains(wordUpper)) {
      repository.addCoins(5);
      showToast(onBonusWordMsg(wordUpper, 5), Icons.stars);
      return true;
    }

    // 3. Not in puzzle
    showToast(notInPuzzleMsg, Icons.close);
    return false;
  }

  void _triggerNewlySolved(String wordId) {
    _newlySolvedWordId = wordId;
    _solveTimer?.cancel();
    _solveTimer = Timer(const Duration(milliseconds: 900), () {
      _newlySolvedWordId = null;
      if (hasListeners) {
        notifyListeners();
      }
    });
  }

  bool useLetterHint() {
    if (repository.useLetterHint()) {
      if (!activeWord.isSolved) {
        activeWord.isSolved = true;
        _triggerNewlySolved(activeWord.id);
        showToast('Revealed "${activeWord.word}"!', Icons.lightbulb);

        final allSolved = _level.words.every((w) => w.isSolved);
        if (allSolved) {
          _isLevelComplete = true;
          repository.completeLevel(_level.levelNumber, 3, 25);
        } else {
          _selectFirstUnsolvedWord();
        }
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  bool useWordReveal() {
    if (repository.useWordReveal()) {
      if (!activeWord.isSolved) {
        activeWord.isSolved = true;
        _triggerNewlySolved(activeWord.id);
        showToast('Word "${activeWord.word}" revealed!', Icons.auto_fix_high);

        final allSolved = _level.words.every((w) => w.isSolved);
        if (allSolved) {
          _isLevelComplete = true;
          repository.completeLevel(_level.levelNumber, 3, 25);
        } else {
          _selectFirstUnsolvedWord();
        }
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  bool useCleanse() {
    if (repository.useCleanse()) {
      showToast('Grid validated & cleansed!', Icons.check_circle);
      notifyListeners();
      return true;
    }
    return false;
  }

  void replayLevel() {
    _level = _level.copyFresh();
    _isLevelComplete = false;
    _selectFirstUnsolvedWord();
    notifyListeners();
  }
}
