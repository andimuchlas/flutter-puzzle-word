import 'package:flutter/material.dart';
import '../../../../core/services/game_state.dart';
import '../../../../core/theme/island_colors.dart';
import '../../../../core/theme/island_typography.dart';
import '../../../../l10n/app_localizations.dart';

class SettingsSheet extends StatelessWidget {
  const SettingsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ListenableBuilder(
      listenable: GameState(),
      builder: (context, _) {
        final gameState = GameState();

        return Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          decoration: const BoxDecoration(
            color: IslandColors.surfaceContainerLowest,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: IslandColors.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                l10n?.settings ?? 'Settings',
                style: IslandTypography.headlineMd(color: IslandColors.onSurface),
              ),
              const SizedBox(height: 16),

              // Sound
              _buildToggleTile(
                icon: Icons.volume_up,
                title: l10n?.soundEffects ?? 'Sound Effects',
                value: gameState.soundEnabled,
                onChanged: (_) => gameState.toggleSound(),
              ),
              const Divider(color: IslandColors.outlineLight, height: 1),

              // Music
              _buildToggleTile(
                icon: Icons.music_note,
                title: l10n?.music ?? 'Music',
                value: gameState.musicEnabled,
                onChanged: (_) => gameState.toggleMusic(),
              ),
              const Divider(color: IslandColors.outlineLight, height: 1),

              // Haptics
              _buildToggleTile(
                icon: Icons.vibration,
                title: l10n?.hapticFeedback ?? 'Haptic Feedback',
                value: gameState.vibrationEnabled,
                onChanged: (_) => gameState.toggleVibration(),
              ),
              const Divider(color: IslandColors.outlineLight, height: 1),

              // Language Selector Tile
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.language, color: IslandColors.onSurfaceVariant),
                title: Text(
                  l10n?.language ?? 'Language',
                  style: IslandTypography.bodyMd(color: IslandColors.onSurface),
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: IslandColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: IslandColors.outlineLight),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: gameState.languageCode,
                      isDense: true,
                      icon: const Icon(Icons.arrow_drop_down, color: IslandColors.primary),
                      items: const [
                        DropdownMenuItem(
                          value: 'en',
                          child: Text('English (US)'),
                        ),
                        DropdownMenuItem(
                          value: 'id',
                          child: Text('Bahasa Indonesia'),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          gameState.setLanguage(val);
                        }
                      },
                    ),
                  ),
                ),
              ),
              const Divider(color: IslandColors.outlineLight, height: 1),

              // Restore Purchases
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.restore, color: IslandColors.onSurfaceVariant),
                title: Text(
                  l10n?.restorePurchases ?? 'Restore Purchases',
                  style: IslandTypography.bodyMd(color: IslandColors.onSurface),
                ),
                trailing: const Icon(Icons.chevron_right, color: IslandColors.outlineVariant),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Purchases restored successfully.')),
                  );
                },
              ),

              const SizedBox(height: 12),
              Text(
                'Word Archipelago • Version 1.0.0 (Build 5 Levels)',
                style: IslandTypography.labelSm(color: IslandColors.outline),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToggleTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      secondary: Icon(icon, color: IslandColors.onSurfaceVariant),
      title: Text(
        title,
        style: IslandTypography.bodyMd(color: IslandColors.onSurface),
      ),
      value: value,
      activeTrackColor: IslandColors.primary,
      onChanged: onChanged,
    );
  }
}
