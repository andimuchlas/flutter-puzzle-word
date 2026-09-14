import 'package:flutter/material.dart';
import '../../../../core/services/game_state.dart';
import '../../../../core/theme/island_colors.dart';
import '../../../../core/theme/island_typography.dart';
import '../../../../core/widgets/coin_badge.dart';
import '../../../../domain/models/puzzle_level.dart';
import '../../../../l10n/app_localizations.dart';
import '../../gameplay/screens/gameplay_screen.dart';

class IslandMapScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const IslandMapScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ListenableBuilder(
      listenable: GameState(),
      builder: (context, _) {
        final gameState = GameState();

        return Scaffold(
          backgroundColor: IslandColors.surface,
          body: SafeArea(
            child: Column(
              children: [
                // 1. TOP APP BAR
                Container(
                  height: 58,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      Row(
                        children: [
                          if (onBack != null)
                            GestureDetector(
                              onTap: onBack,
                              child: Container(
                                width: 38,
                                height: 38,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: IslandColors.surfaceContainerLow,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: IslandColors.onSurface,
                                  size: 20,
                                ),
                              ),
                            ),
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: IslandColors.primaryFixed,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.explore,
                              color: IslandColors.primary,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                l10n?.appTitle.toUpperCase() ?? 'WORD ARCHIPELAGO',
                                style: IslandTypography.labelSm(
                                  color: IslandColors.primary,
                                ).copyWith(fontWeight: FontWeight.bold, fontSize: 9),
                              ),
                              Text(
                                l10n?.islandsMap ?? 'Islands Map',
                                style: IslandTypography.headlineSm(
                                  color: IslandColors.onSurface,
                                ).copyWith(fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IslandCoinBadge(coins: gameState.coins),
                          const SizedBox(width: 8),
                          Container(
                            width: 34,
                            height: 34,
                            decoration: const BoxDecoration(
                              color: IslandColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 19,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 2. SCROLLABLE MAP BODY (Constrained for tablets)
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                        child: Column(
                          children: [
                            // Top Island Summary Card
                            _buildSummaryCard(gameState, l10n),

                            const SizedBox(height: 16),

                            // Winding Path Canvas Container with 5 Levels
                            _buildWindingPathCanvas(context, gameState, l10n),

                            const SizedBox(height: 16),

                            // Island 2: Preview & Unlock Card
                            _buildIsland2Preview(),
                          ],
                        ),
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

  Widget _buildSummaryCard(GameState gameState, AppLocalizations? l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: IslandColors.surfaceContainerHighest),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F0F172A),
            offset: Offset(0, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.explore, size: 14, color: IslandColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        l10n?.zoneProgress ?? 'ZONE 1 OF 6',
                        style: IslandTypography.labelSm(
                          color: IslandColors.primary,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Island 1: Tropical Coast',
                    style: IslandTypography.headlineSm(
                      color: IslandColors.onSurface,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: IslandColors.secondaryFixed.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 16,
                      color: IslandColors.secondaryContainer,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${gameState.totalStars} / 15',
                      style: IslandTypography.labelMd(
                        color: IslandColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n?.archipelagoProgress ?? 'Archipelago Progress',
                style: IslandTypography.bodySm(
                  color: IslandColors.onSurfaceVariant,
                ),
              ),
              Text(
                '${gameState.currentLevel} / 5 Levels (${(gameState.currentLevel * 20)}%)',
                style: IslandTypography.labelSm(
                  color: IslandColors.primary,
                ).copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 6),

          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: (gameState.currentLevel / 5.0).clamp(0.0, 1.0),
              minHeight: 10,
              backgroundColor: IslandColors.surfaceContainerHigh,
              valueColor: const AlwaysStoppedAnimation(IslandColors.tertiary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWindingPathCanvas(
    BuildContext context,
    GameState gameState,
    AppLocalizations? l10n,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: IslandColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: IslandColors.surfaceContainerHighest),
      ),
      child: Column(
        children: [
          // Render levels 5 down to 1 (top to bottom map trail)
          for (int lvl = 5; lvl >= 1; lvl--) ...[
            _buildNodeForLevel(context, gameState, lvl, l10n),
            if (lvl > 1) const SizedBox(height: 26),
          ],
        ],
      ),
    );
  }

  Widget _buildNodeForLevel(
    BuildContext context,
    GameState gameState,
    int levelNumber,
    AppLocalizations? l10n,
  ) {
    final offsets = [0.0, -35.0, 35.0, -30.0, 30.0, 0.0];
    final offsetX = offsets[levelNumber % offsets.length];

    _NodeStatus status;
    int stars = 0;

    if (levelNumber < gameState.currentLevel) {
      status = _NodeStatus.mastered;
      stars = 3;
    } else if (levelNumber == gameState.currentLevel) {
      status = _NodeStatus.active;
    } else if (levelNumber <= gameState.highestUnlockedLevel) {
      status = _NodeStatus.nextUp;
    } else {
      status = _NodeStatus.locked;
    }

    final isClickable = status != _NodeStatus.locked;

    return _buildLevelNode(
      levelNumber: levelNumber,
      status: status,
      stars: stars,
      offsetX: offsetX,
      l10n: l10n,
      onTap: isClickable
          ? () {
              gameState.setCurrentLevel(levelNumber);
              _openGameplay(context, levelNumber);
            }
          : null,
    );
  }

  void _openGameplay(BuildContext context, int levelNumber) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GameplayScreen(level: PuzzleLevel.getLevel(levelNumber)),
      ),
    );
  }

  Widget _buildLevelNode({
    required int levelNumber,
    required _NodeStatus status,
    int stars = 0,
    double offsetX = 0,
    required AppLocalizations? l10n,
    VoidCallback? onTap,
  }) {
    return Transform.translate(
      offset: Offset(offsetX, 0),
      child: Column(
        children: [
          if (status == _NodeStatus.active) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: IslandColors.secondaryContainer,
                borderRadius: BorderRadius.circular(999),
                boxShadow: const [
                  BoxShadow(
                    color: IslandColors.secondaryDark,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.play_arrow, size: 14, color: Colors.white),
                  Text(
                    l10n?.play ?? 'PLAY',
                    style: IslandTypography.labelSm(color: Colors.white)
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
          ],

          GestureDetector(
            onTap: onTap,
            child: Container(
              width: status == _NodeStatus.active ? 68 : 58,
              height: status == _NodeStatus.active ? 68 : 58,
              decoration: BoxDecoration(
                color: _nodeColor(status),
                shape: BoxShape.circle,
                border: Border.all(
                  color: status == _NodeStatus.active
                      ? IslandColors.primaryLight
                      : Colors.transparent,
                  width: status == _NodeStatus.active ? 3 : 0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _nodeShadowColor(status),
                    offset: const Offset(0, 4),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: status == _NodeStatus.locked
                    ? const Icon(Icons.lock, color: IslandColors.outline, size: 20)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            levelNumber.toString(),
                            style: IslandTypography.titleTile(
                              color: status == _NodeStatus.nextUp
                                   ? IslandColors.primary
                                  : Colors.white,
                            ).copyWith(fontSize: 18),
                          ),
                          if (stars > 0)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0; i < 3; i++)
                                  Icon(
                                    Icons.star,
                                    size: 10,
                                    color: i < stars
                                        ? IslandColors.secondaryContainer
                                        : IslandColors.surfaceContainerHighest,
                                  ),
                              ],
                            ),
                        ],
                      ),
              ),
            ),
          ),

          const SizedBox(height: 4),
          Text(
            _statusLabel(status, l10n),
            style: IslandTypography.labelSm(color: _statusLabelColor(status))
                .copyWith(fontSize: 9.5),
          ),
        ],
      ),
    );
  }

  Color _nodeColor(_NodeStatus status) {
    switch (status) {
      case _NodeStatus.locked:
        return IslandColors.surfaceContainerHighest;
      case _NodeStatus.nextUp:
        return Colors.white;
      case _NodeStatus.active:
        return IslandColors.primary;
      case _NodeStatus.cleared:
      case _NodeStatus.mastered:
        return IslandColors.tertiary;
    }
  }

  Color _nodeShadowColor(_NodeStatus status) {
    switch (status) {
      case _NodeStatus.locked:
        return IslandColors.outlineVariant;
      case _NodeStatus.nextUp:
        return IslandColors.surfaceContainerHighest;
      case _NodeStatus.active:
        return IslandColors.primaryDark;
      case _NodeStatus.cleared:
      case _NodeStatus.mastered:
        return const Color(0xFF005236);
    }
  }

  String _statusLabel(_NodeStatus status, AppLocalizations? l10n) {
    switch (status) {
      case _NodeStatus.locked:
        return l10n?.locked ?? 'Locked';
      case _NodeStatus.nextUp:
        return l10n?.nextUp ?? 'Next Up';
      case _NodeStatus.active:
        return l10n?.ready ?? 'Ready';
      case _NodeStatus.cleared:
        return l10n?.cleared ?? 'Cleared';
      case _NodeStatus.mastered:
        return l10n?.mastered ?? 'Mastered';
    }
  }

  Color _statusLabelColor(_NodeStatus status) {
    switch (status) {
      case _NodeStatus.locked:
        return IslandColors.outline;
      case _NodeStatus.nextUp:
      case _NodeStatus.active:
        return IslandColors.primary;
      case _NodeStatus.cleared:
      case _NodeStatus.mastered:
        return IslandColors.tertiary;
    }
  }

  Widget _buildIsland2Preview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: IslandColors.surfaceContainerHighest),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: IslandColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.lock, color: IslandColors.outline, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Island 2: Coral Lagoon',
                      style: IslandTypography.headlineSm(
                        color: IslandColors.onSurface,
                      ).copyWith(fontSize: 14),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: IslandColors.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'LOCKED',
                        style: IslandTypography.labelSm(
                          color: IslandColors.onSurfaceVariant,
                        ).copyWith(fontSize: 8.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Requires completing Level 5 in Island 1',
                  style: IslandTypography.bodySm(
                    color: IslandColors.onSurfaceVariant,
                  ).copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum _NodeStatus { locked, nextUp, active, cleared, mastered }
