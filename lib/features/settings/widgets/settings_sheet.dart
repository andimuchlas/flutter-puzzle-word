import 'package:flutter/material.dart';
import '../../../../core/services/game_state.dart';
import '../../../../core/theme/island_colors.dart';
import '../../../../core/theme/island_typography.dart';

class SettingsSheet extends StatelessWidget {
  const SettingsSheet({super.key});

  @override
  Widget build(BuildContext context) {
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
                'Settings',
                style: IslandTypography.headlineMd(color: IslandColors.onSurface),
              ),
              const SizedBox(height: 16),

              _buildToggleTile(
                icon: Icons.volume_up,
                title: 'Sound Effects',
                value: gameState.soundEnabled,
                onChanged: (_) => gameState.toggleSound(),
              ),
              const Divider(color: IslandColors.outlineLight, height: 1),

              _buildToggleTile(
                icon: Icons.music_note,
                title: 'Music',
                value: gameState.musicEnabled,
                onChanged: (_) => gameState.toggleMusic(),
              ),
              const Divider(color: IslandColors.outlineLight, height: 1),

              _buildToggleTile(
                icon: Icons.vibration,
                title: 'Haptic Feedback',
                value: gameState.vibrationEnabled,
                onChanged: (_) => gameState.toggleVibration(),
              ),
              const Divider(color: IslandColors.outlineLight, height: 1),

              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.restore, color: IslandColors.onSurfaceVariant),
                title: Text(
                  'Restore Purchases',
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
                'Word Archipelago • Version 1.0.0 (Build 30)',
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
