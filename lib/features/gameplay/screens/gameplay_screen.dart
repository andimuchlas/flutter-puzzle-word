import 'package:flutter/material.dart';
import 'package:word_archipelago/core/services/game_state.dart';
import 'package:word_archipelago/core/theme/island_colors.dart';
import 'package:word_archipelago/core/theme/island_typography.dart';
import 'package:word_archipelago/core/widgets/coin_badge.dart';
import 'package:word_archipelago/domain/models/puzzle_level.dart';
import 'package:word_archipelago/features/gameplay/view_models/gameplay_view_model.dart';
import 'package:word_archipelago/features/gameplay/widgets/crossword_grid_widget.dart';
import 'package:word_archipelago/features/gameplay/widgets/island_scenic_background.dart';
import 'package:word_archipelago/features/gameplay/widgets/letter_wheel/letter_wheel_widget.dart';
import 'package:word_archipelago/features/victory/widgets/level_complete_dialog.dart';
import 'package:word_archipelago/l10n/app_localizations.dart';

class GameplayScreen extends StatefulWidget {
  final PuzzleLevel? level;

  const GameplayScreen({super.key, this.level});

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  late GameplayViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    final initialLevel = widget.level ?? PuzzleLevel.getLevel(GameState().currentLevel);
    _viewModel = GameplayViewModel(
      level: initialLevel,
      repository: GameState().repository,
    );
    _viewModel.addListener(_onViewModelUpdate);
  }

  @override
  void didUpdateWidget(covariant GameplayScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.level != null && widget.level != oldWidget.level) {
      _viewModel.removeListener(_onViewModelUpdate);
      _viewModel.dispose();
      _viewModel = GameplayViewModel(
        level: widget.level!,
        repository: GameState().repository,
      );
      _viewModel.addListener(_onViewModelUpdate);
    }
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelUpdate);
    _viewModel.dispose();
    super.dispose();
  }

  void _onViewModelUpdate() {
    if (!mounted) return;
    if (_viewModel.isLevelComplete) {
      _showLevelCompleteDialog();
    }
  }

  void _showLevelCompleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => LevelCompleteDialog(
        levelNumber: _viewModel.level.levelNumber,
        islandName: _viewModel.level.islandName,
        keyword: _viewModel.level.words.isNotEmpty
            ? _viewModel.level.words.first.word
            : 'ISLAND',
        earnedCoins: 25,
        onNextLevel: () {
          Navigator.of(ctx).pop();
          final nextLevelNum = _viewModel.level.levelNumber + 1;
          if (nextLevelNum <= 5) {
            setState(() {
              _viewModel.dispose();
              _viewModel = GameplayViewModel(
                level: PuzzleLevel.getLevel(nextLevelNum),
                repository: GameState().repository,
              );
              _viewModel.addListener(_onViewModelUpdate);
            });
          } else {
            Navigator.of(context).pop();
          }
        },
        onWatchDoubleVideo: () {
          GameState().addCoins(50);
          Navigator.of(ctx).pop();
          final nextLevelNum = _viewModel.level.levelNumber + 1;
          if (nextLevelNum <= 5) {
            setState(() {
              _viewModel.dispose();
              _viewModel = GameplayViewModel(
                level: PuzzleLevel.getLevel(nextLevelNum),
                repository: GameState().repository,
              );
              _viewModel.addListener(_onViewModelUpdate);
            });
          } else {
            Navigator.of(context).pop();
          }
        },
        onReplay: () {
          Navigator.of(ctx).pop();
          _viewModel.replayLevel();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ListenableBuilder(
      listenable: Listenable.merge([GameState(), _viewModel]),
      builder: (context, _) {
        final gameState = GameState();
        final level = _viewModel.level;

        return Scaffold(
          body: IslandScenicBackground(
            islandNumber: level.islandNumber,
            child: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      // Top App Bar
                      _buildAppBar(context, gameState, level, l10n),

                      // Main Content (Adaptive layout for Phone & Tablet)
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth >= 600) {
                              return _buildWideLayout(gameState, level);
                            } else {
                              return _buildPhoneLayout(gameState, level);
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                // Floating Toast Notification
                if (_viewModel.toastMessage != null)
                  Positioned(
                    top: 68,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
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
                            if (_viewModel.toastIcon != null) ...[
                              Icon(
                                _viewModel.toastIcon,
                                color: IslandColors.secondaryContainer,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                            ],
                            Text(
                              _viewModel.toastMessage!,
                              style: IslandTypography.labelSm(
                                color: Colors.white,
                              ).copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

  Widget _buildAppBar(
    BuildContext context,
    GameState gameState,
    PuzzleLevel level,
    AppLocalizations? l10n,
  ) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button (Frosted Circle)
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.35),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.40),
                  width: 1.2,
                ),
              ),
              child: const Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),

          // Island & Level Title
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n?.islandLevelHeader(level.islandNumber, level.levelNumber) ??
                        'Island ${level.islandNumber} • Level ${level.levelNumber}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: IslandTypography.headlineSm(
                      color: Colors.white,
                    ).copyWith(
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                      shadows: const [
                        Shadow(
                          color: Colors.black54,
                          offset: Offset(0, 1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          level.islandName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: IslandTypography.bodySm(
                            color: Colors.white.withOpacity(0.85),
                          ).copyWith(
                            fontSize: 11,
                            shadows: const [
                              Shadow(
                                color: Colors.black54,
                                offset: Offset(0, 1),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '•',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: 44,
                        height: 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: (level.levelNumber / 5.0).clamp(0.0, 1.0),
                            backgroundColor: Colors.white.withOpacity(0.3),
                            valueColor: const AlwaysStoppedAnimation(
                              Color(0xFFFBBF24),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${level.levelNumber}/5',
                        style: const TextStyle(
                          color: Color(0xFFFDE68A),
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Coins Badge & Pause
          Row(
            children: [
              IslandCoinBadge(coins: gameState.coins),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.35),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.40),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.pause,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneLayout(GameState gameState, PuzzleLevel level) {
    final l10n = AppLocalizations.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxH = constraints.maxHeight;
        // Dynamically scale letter wheel based on viewport height
        final wheelSize = (maxH * 0.30).clamp(190.0, 220.0);

        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
          child: Column(
            children: [
              // Floating Crossword Grid (Scales adaptively to fill upper space)
              Expanded(
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: CrosswordGridWidget(
                      level: level,
                      activeWord: _viewModel.activeWord,
                      newlySolvedWordId: _viewModel.newlySolvedWordId,
                      onWordSelected: _viewModel.selectWord,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Wordscapes Action Hub: Side Powerup Buttons + Letter Wheel
              LetterWheelWidget(
                letters: level.wheelLetters,
                size: wheelSize,
                onLetterHint: _viewModel.useLetterHint,
                letterHintCount: gameState.hintCount,
                onWordHint: _viewModel.useWordReveal,
                wordHintCount: gameState.wordRevealCount,
                onTargetHint: _viewModel.useCleanse,
                targetHintCount: gameState.cleanseCount,
                onWordSubmitted: (w) => _viewModel.handleWordSubmitted(
                  w,
                  onSolvedMsg: (word) =>
                      l10n?.wordSolved(word) ?? 'Solved "$word"!',
                  onAlreadySolvedMsg: (word) =>
                      l10n?.alreadySolved(word) ?? 'Already solved "$word"!',
                  onBonusWordMsg: (word, coins) =>
                      l10n?.bonusWordFound(word, coins) ??
                      'Bonus word "$word" (+$coins coins)!',
                  notInPuzzleMsg: l10n?.notInPuzzle ?? 'Not in puzzle',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWideLayout(GameState gameState, PuzzleLevel level) {
    final l10n = AppLocalizations.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 960),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left Column: Floating Crossword Grid
              Expanded(
                flex: 5,
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: CrosswordGridWidget(
                      level: level,
                      activeWord: _viewModel.activeWord,
                      newlySolvedWordId: _viewModel.newlySolvedWordId,
                      onWordSelected: _viewModel.selectWord,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 24),

              // Right Column: Letter Wheel & Action Controls
              Expanded(
                flex: 4,
                child: Center(
                  child: LetterWheelWidget(
                    letters: level.wheelLetters,
                    size: 240,
                    onLetterHint: _viewModel.useLetterHint,
                    letterHintCount: gameState.hintCount,
                    onWordHint: _viewModel.useWordReveal,
                    wordHintCount: gameState.wordRevealCount,
                    onTargetHint: _viewModel.useCleanse,
                    targetHintCount: gameState.cleanseCount,
                    onWordSubmitted: (w) => _viewModel.handleWordSubmitted(
                      w,
                      onSolvedMsg: (word) =>
                          l10n?.wordSolved(word) ?? 'Solved "$word"!',
                      onAlreadySolvedMsg: (word) =>
                          l10n?.alreadySolved(word) ?? 'Already solved "$word"!',
                      onBonusWordMsg: (word, coins) =>
                          l10n?.bonusWordFound(word, coins) ??
                          'Bonus word "$word" (+$coins coins)!',
                      notInPuzzleMsg: l10n?.notInPuzzle ?? 'Not in puzzle',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
