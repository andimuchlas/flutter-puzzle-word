import 'package:flutter/material.dart';
import '../../../../core/services/game_state.dart';
import '../../../../core/theme/island_colors.dart';
import '../../../../core/theme/island_typography.dart';
import '../../../../core/widgets/coin_badge.dart';
import '../../../../core/widgets/tactile_button.dart';
import '../../daily/widgets/daily_reward_sheet.dart';
import '../../gameplay/screens/gameplay_screen.dart';
import '../../map/screens/island_map_screen.dart';
import '../../settings/widgets/settings_sheet.dart';
import '../../shop/widgets/shop_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  void _openGameplay() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const GameplayScreen()),
    );
  }

  void _openDailyGift() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const DailyRewardSheet(),
    );
  }

  void _openShop() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ShopSheet(),
    );
  }

  void _openSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SettingsSheet(),
    );
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
            child: _currentNavIndex == 1
                ? IslandMapScreen(onBack: () => setState(() => _currentNavIndex = 0))
                : _buildHomeBody(gameState),
          ),
          bottomNavigationBar: _buildBottomNav(),
        );
      },
    );
  }

  Widget _buildHomeBody(GameState gameState) {
    return Column(
      children: [
        // 1. TOP BAR
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.92),
            border: Border(
              bottom: BorderSide(
                color: IslandColors.surfaceContainerHigh.withOpacity(0.8),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo + Title
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: IslandColors.primaryFixed,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.beach_access,
                      color: IslandColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'WORD ARCHIPELAGO',
                    style: IslandTypography.displayLg(
                      color: IslandColors.primary,
                    ).copyWith(fontSize: 16, letterSpacing: 0.5),
                  ),
                ],
              ),

              // Coins + Settings
              Row(
                children: [
                  IslandCoinBadge(
                    coins: gameState.coins,
                    onAddTap: _openShop,
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _openSettings,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: IslandColors.surfaceContainerLowest,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: IslandColors.surfaceContainerHighest,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: IslandColors.surfaceContainerHighest,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.settings,
                        color: IslandColors.onSurfaceVariant,
                        size: 19,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // 2. MAIN SCROLLABLE BODY
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Island Preview Card
                _buildHeroIslandCard(gameState),

                const SizedBox(height: 16),

                // Hero CTA - The Dominant Action
                _buildHeroCTA(gameState),

                const SizedBox(height: 16),

                // Daily Gift Reward Card
                _buildDailyGiftCard(gameState),

                const SizedBox(height: 16),

                // Quick Inventory Preview
                Text(
                  'QUICK INVENTORY',
                  style: IslandTypography.labelSm(color: IslandColors.outline)
                      .copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.8),
                ),
                const SizedBox(height: 8),
                _buildQuickInventory(gameState),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroIslandCard(GameState gameState) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: IslandColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: IslandColors.surfaceContainerHighest.withOpacity(0.8),
        ),
        boxShadow: const [
          BoxShadow(
            color: IslandColors.surfaceContainerHighest,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // 3D Island Artwork Container
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE0F2FE),
                  Color(0xFFFEF3C7),
                ],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Ocean Wave Lines
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < 5; i++)
                        Container(
                          width: 40,
                          height: 3,
                          decoration: BoxDecoration(
                            color: IslandColors.primaryFixed.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                    ],
                  ),
                ),

                // Tropical Island Motif
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: IslandColors.secondaryContainer.withOpacity(0.9),
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: IslandColors.secondaryDark,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.park,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'Tropical Archipelago',
                        style: IslandTypography.labelSm(
                          color: IslandColors.primary,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Island Title & Level indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CURRENT ISLAND',
                      style: IslandTypography.labelSm(color: IslandColors.outline)
                          .copyWith(fontSize: 9),
                    ),
                    Text(
                      'Island 1: Tropical Coast',
                      style: IslandTypography.headlineSm(
                        color: IslandColors.onSurface,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: IslandColors.surfaceContainer,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: IslandColors.surfaceContainerHighest,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: IslandColors.secondaryContainer,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Level ${gameState.currentLevel} of 30',
                        style: IslandTypography.labelSm(
                          color: IslandColors.primary,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCTA(GameState gameState) {
    return TactileButton(
      onPressed: _openGameplay,
      backgroundColor: IslandColors.gameGreen,
      bevelColor: IslandColors.gameGreenShadow,
      shadowHeight: 6,
      borderRadius: 20,
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CONTINUE',
                style: IslandTypography.displayLg(color: Colors.white).copyWith(
                  fontSize: 26,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    'Level ${gameState.currentLevel}',
                    style: IslandTypography.bodySm(
                      color: IslandColors.tertiaryFixed,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 6),
                  const Text('•', style: TextStyle(color: Colors.white70)),
                  const SizedBox(width: 6),
                  Text(
                    'Crossword Puzzle',
                    style: IslandTypography.bodySm(
                      color: IslandColors.tertiaryFixed,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Tactile Play Disc
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.22),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.35),
              ),
            ),
            child: const Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 34,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyGiftCard(GameState gameState) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFFBEB), Color(0xFFFFF7ED)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFDE68A)),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFFDE68A),
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: IslandColors.secondaryContainer,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: IslandColors.secondaryDark,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.card_giftcard,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Island Gift',
                  style: IslandTypography.headlineSm(
                    color: const Color(0xFF78350F),
                  ).copyWith(fontSize: 14),
                ),
                Text(
                  gameState.dailyClaimed
                      ? 'Claimed for today! Next tomorrow.'
                      : 'Claim free hints & bonus coins',
                  style: IslandTypography.bodySm(
                    color: const Color(0xFF92400E),
                  ).copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          TactileButton(
            onPressed: gameState.dailyClaimed ? null : _openDailyGift,
            backgroundColor: gameState.dailyClaimed
                ? IslandColors.outlineVariant
                : IslandColors.secondaryContainer,
            bevelColor: gameState.dailyClaimed
                ? IslandColors.outline
                : IslandColors.secondaryDark,
            shadowHeight: 3,
            borderRadius: 12,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Text(
              gameState.dailyClaimed ? 'Claimed' : 'Claim',
              style: IslandTypography.labelMd(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInventory(GameState gameState) {
    return Row(
      children: [
        Expanded(
          child: _buildInventoryCard(
            icon: Icons.lightbulb,
            iconColor: IslandColors.primaryLight,
            title: 'Hint',
            count: gameState.hintCount,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildInventoryCard(
            icon: Icons.auto_awesome,
            iconColor: const Color(0xFF4F46E5),
            title: 'Word Reveal',
            count: gameState.wordRevealCount,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildInventoryCard(
            icon: Icons.auto_fix_high,
            iconColor: IslandColors.gameGreen,
            title: 'Cleanse',
            count: gameState.cleanseCount,
          ),
        ),
      ],
    );
  }

  Widget _buildInventoryCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required int count,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: IslandColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: IslandColors.surfaceContainerHighest),
        boxShadow: const [
          BoxShadow(
            color: IslandColors.surfaceContainerHighest,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: IslandTypography.labelSm(color: IslandColors.outline)
                .copyWith(fontSize: 10),
          ),
          const SizedBox(height: 2),
          Text(
            'x$count',
            style: IslandTypography.headlineSm(color: IslandColors.onSurface)
                .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.96),
        border: Border(
          top: BorderSide(
            color: IslandColors.surfaceContainerHigh.withOpacity(0.8),
          ),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A0F172A),
            offset: Offset(0, -4),
            blurRadius: 16,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.cottage,
            label: 'Home',
            isSelected: _currentNavIndex == 0,
            onTap: () => setState(() => _currentNavIndex = 0),
          ),
          _buildNavItem(
            icon: Icons.explore,
            label: 'Islands',
            isSelected: _currentNavIndex == 1,
            onTap: () => setState(() => _currentNavIndex = 1),
          ),
          _buildNavItem(
            icon: Icons.storefront,
            label: 'Shop',
            isSelected: false,
            onTap: _openShop,
          ),
          _buildNavItem(
            icon: Icons.settings,
            label: 'Settings',
            isSelected: false,
            onTap: _openSettings,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final color = isSelected ? IslandColors.primary : IslandColors.onSurfaceVariant;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 2),
            Text(
              label,
              style: IslandTypography.labelSm(color: color).copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
