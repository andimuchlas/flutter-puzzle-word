import 'package:flutter/material.dart';
import '../../../../core/services/game_state.dart';
import '../../../../core/theme/island_colors.dart';
import '../../../../core/theme/island_typography.dart';
import '../../../../core/widgets/coin_badge.dart';
import '../../victory/widgets/level_complete_dialog.dart';
import '../models/crossword_models.dart';
import '../widgets/active_clue_banner.dart';
import '../widgets/clue_accordion_widget.dart';
import '../widgets/crossword_grid_widget.dart';
import '../widgets/letter_wheel/letter_wheel_widget.dart';
import '../widgets/powerup_dock.dart';

class GameplayScreen extends StatefulWidget {
  final PuzzleLevel? level;

  const GameplayScreen({super.key, this.level});

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  late PuzzleLevel _level;
  int _activeWordIndex = 0;
  String? _newlySolvedWordId;
  String? _toastMessage;
  IconData? _toastIcon;

  @override
  void initState() {
    super.initState();
    _level = widget.level ?? PuzzleLevel.getSampleLevel12();
    _selectFirstUnsolvedWord();
  }

  void _selectFirstUnsolvedWord() {
    for (int i = 0; i < _level.words.length; i++) {
      if (!_level.words[i].isSolved) {
        _activeWordIndex = i;
        return;
      }
    }
  }

  CrosswordWord get _activeWord => _level.words[_activeWordIndex];

  void _nextClue() {
    setState(() {
      _activeWordIndex = (_activeWordIndex + 1) % _level.words.length;
    });
  }

  void _prevClue() {
    setState(() {
      _activeWordIndex =
          (_activeWordIndex - 1 + _level.words.length) % _level.words.length;
    });
  }

  void _showToast(String message, [IconData? icon]) {
    setState(() {
      _toastMessage = message;
      _toastIcon = icon;
    });
    Future.delayed(const Duration(milliseconds: 1600), () {
      if (mounted) {
        setState(() {
          _toastMessage = null;
        });
      }
    });
  }

  void _handleWordSubmitted(String submittedWord) {
    final wordUpper = submittedWord.toUpperCase();

    // 1. Check if word matches any unsolved crossword word
    CrosswordWord? matchedWord;
    for (final w in _level.words) {
      if (w.word == wordUpper) {
        if (w.isSolved) {
          _showToast('Already found "$wordUpper"!', Icons.info_outline);
          return;
        } else {
          matchedWord = w;
          break;
        }
      }
    }

    if (matchedWord != null) {
      setState(() {
        matchedWord!.isSolved = true;
        _newlySolvedWordId = matchedWord.id;
      });

      _showToast('Solved "${matchedWord.word}"!', Icons.check_circle);

      // Check if all words in level are solved
      final allSolved = _level.words.every((w) => w.isSolved);
      if (allSolved) {
        Future.delayed(const Duration(milliseconds: 700), () {
          _handleLevelComplete();
        });
      } else {
        _selectFirstUnsolvedWord();
      }

      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          setState(() {
            _newlySolvedWordId = null;
          });
        }
      });
      return;
    }

    // 2. Check if it's in bonus words
    if (_level.bonusWords.contains(wordUpper)) {
      GameState().addCoins(5);
      _showToast('Bonus word "$wordUpper" (+5 coins)!', Icons.stars);
      return;
    }

    // 3. Invalid word
    _showToast('Not in puzzle', Icons.close);
  }

  void _handleLevelComplete() {
    GameState().completeCurrentLevel(3, 25);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => LevelCompleteDialog(
        levelNumber: _level.levelNumber,
        islandName: _level.islandName,
        keyword: 'ISLAND',
        earnedCoins: 25,
        onNextLevel: () {
          Navigator.of(ctx).pop();
          Navigator.of(context).pop();
        },
        onWatchDoubleVideo: () {
          GameState().addCoins(50);
          Navigator.of(ctx).pop();
          Navigator.of(context).pop();
        },
        onReplay: () {
          Navigator.of(ctx).pop();
          setState(() {
            for (final w in _level.words) {
              w.isSolved = false;
            }
            _selectFirstUnsolvedWord();
          });
        },
      ),
    );
  }

  void _useLetterHint() {
    if (GameState().useHint()) {
      // Reveal a cell in active word that isn't solved
      if (!_activeWord.isSolved) {
        setState(() {
          _activeWord.isSolved = true;
          _newlySolvedWordId = _activeWord.id;
        });
        _showToast('Letter hint revealed word "${_activeWord.word}"!', Icons.lightbulb);
        _selectFirstUnsolvedWord();
      } else {
        _showToast('Current word already revealed!');
      }
    } else {
      _showToast('Need 50 coins for Letter Hint!');
    }
  }

  void _useWordHint() {
    if (GameState().useWordReveal()) {
      setState(() {
        _activeWord.isSolved = true;
        _newlySolvedWordId = _activeWord.id;
      });
      _showToast('Word "${_activeWord.word}" revealed!', Icons.auto_fix_high);

      final allSolved = _level.words.every((w) => w.isSolved);
      if (allSolved) {
        Future.delayed(const Duration(milliseconds: 600), _handleLevelComplete);
      } else {
        _selectFirstUnsolvedWord();
      }
    } else {
      _showToast('Need 100 coins for Word Reveal!');
    }
  }

  void _useCleanse() {
    if (GameState().useCleanse()) {
      _showToast('Grid validated & cleansed!', Icons.check_circle);
    } else {
      _showToast('Need 30 coins for Cleanse!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: GameState(),
      builder: (context, _) {
        final gameState = GameState();

        return Scaffold(
          backgroundColor: IslandColors.surface,
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    // 1. TOP APP BAR
                    Container(
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        border: Border(
                          bottom: BorderSide(
                            color: IslandColors.surfaceContainerHigh.withOpacity(0.8),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back Button
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: IslandColors.surfaceContainerLow,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.chevron_left,
                                color: IslandColors.onSurface,
                              ),
                            ),
                          ),

                          // Island & Level Title
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Island ${_level.islandNumber} • Level ${_level.levelNumber}',
                                style: IslandTypography.headlineSm(
                                  color: IslandColors.onSurface,
                                ).copyWith(fontSize: 14),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                    _level.islandName,
                                    style: IslandTypography.bodySm(
                                      color: IslandColors.onSurfaceVariant,
                                    ).copyWith(fontSize: 10),
                                  ),
                                  const SizedBox(width: 4),
                                  const Text('•', style: TextStyle(color: IslandColors.outlineVariant, fontSize: 10)),
                                  const SizedBox(width: 4),
                                  SizedBox(
                                    width: 48,
                                    height: 5,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(999),
                                      child: LinearProgressIndicator(
                                        value: (_level.levelNumber % 30) / 30.0,
                                        backgroundColor: IslandColors.surfaceContainerHighest,
                                        valueColor: const AlwaysStoppedAnimation(IslandColors.primaryLight),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${_level.levelNumber}/30',
                                    style: IslandTypography.labelSm(
                                      color: IslandColors.primaryLight,
                                    ).copyWith(fontSize: 9.5),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Coins Badge & Pause
                          Row(
                            children: [
                              IslandCoinBadge(coins: gameState.coins),
                              const SizedBox(width: 6),
                              GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: Container(
                                  width: 34,
                                  height: 34,
                                  decoration: BoxDecoration(
                                    color: IslandColors.surfaceContainerLow,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.pause,
                                    color: IslandColors.onSurfaceVariant,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // 2. MAIN SCROLLABLE CONTENT
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                        child: Column(
                          children: [
                            // Active Clue Banner
                            ActiveClueBanner(
                              activeWord: _activeWord,
                              onPrevious: _prevClue,
                              onNext: _nextClue,
                            ),

                            const SizedBox(height: 8),

                            // Crossword Grid
                            CrosswordGridWidget(
                              level: _level,
                              activeWord: _activeWord,
                              newlySolvedWordId: _newlySolvedWordId,
                              onWordSelected: (w) {
                                final idx = _level.words.indexOf(w);
                                if (idx != -1) {
                                  setState(() => _activeWordIndex = idx);
                                }
                              },
                            ),

                            const SizedBox(height: 8),

                            // Compact Dual Clue Accordion
                            ClueAccordionWidget(
                              words: _level.words,
                              activeWord: _activeWord,
                              onSelectWord: (w) {
                                final idx = _level.words.indexOf(w);
                                if (idx != -1) {
                                  setState(() => _activeWordIndex = idx);
                                }
                              },
                            ),

                            const SizedBox(height: 8),

                            // Powerup Dock
                            PowerupDock(
                              letterHintCount: gameState.hintCount,
                              wordHintCount: gameState.wordRevealCount,
                              checkCount: gameState.cleanseCount,
                              onLetterHint: _useLetterHint,
                              onWordHint: _useWordHint,
                              onCheck: _useCleanse,
                            ),

                            const SizedBox(height: 8),

                            // Interactive Letter Wheel
                            LetterWheelWidget(
                              letters: _level.wheelLetters,
                              onWordSubmitted: _handleWordSubmitted,
                              size: 260,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Toast Notification floating overlay
                if (_toastMessage != null)
                  Positioned(
                    top: 68,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xE60F172A),
                          borderRadius: BorderRadius.circular(999),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x33000000),
                              offset: Offset(0, 4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_toastIcon != null) ...[
                              Icon(_toastIcon,
                                  color: IslandColors.secondaryContainer,
                                  size: 16),
                              const SizedBox(width: 6),
                            ],
                            Text(
                              _toastMessage!,
                              style: IslandTypography.labelSm(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
