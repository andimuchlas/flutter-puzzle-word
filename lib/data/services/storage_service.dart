import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/player_progress.dart';

class StorageService {
  static const String _keyCoins = 'coins';
  static const String _keyCurrentLevel = 'currentLevel';
  static const String _keyHighestUnlocked = 'highestUnlockedLevel';
  static const String _keyTotalStars = 'totalStars';
  static const String _keyHintCount = 'hintCount';
  static const String _keyWordRevealCount = 'wordRevealCount';
  static const String _keyCleanseCount = 'cleanseCount';
  static const String _keySound = 'soundEnabled';
  static const String _keyMusic = 'musicEnabled';
  static const String _keyVibration = 'vibrationEnabled';
  static const String _keyDailyClaimed = 'dailyClaimed';
  static const String _keyLanguage = 'languageCode';

  Future<PlayerProgress> loadPlayerProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return PlayerProgress(
        coins: prefs.getInt(_keyCoins) ?? 1450,
        currentLevel: prefs.getInt(_keyCurrentLevel) ?? 1,
        highestUnlockedLevel: prefs.getInt(_keyHighestUnlocked) ?? 1,
        totalStars: prefs.getInt(_keyTotalStars) ?? 0,
        hintCount: prefs.getInt(_keyHintCount) ?? 4,
        wordRevealCount: prefs.getInt(_keyWordRevealCount) ?? 2,
        cleanseCount: prefs.getInt(_keyCleanseCount) ?? 5,
        soundEnabled: prefs.getBool(_keySound) ?? true,
        musicEnabled: prefs.getBool(_keyMusic) ?? true,
        vibrationEnabled: prefs.getBool(_keyVibration) ?? true,
        dailyClaimed: prefs.getBool(_keyDailyClaimed) ?? false,
        languageCode: prefs.getString(_keyLanguage) ?? 'id',
      );
    } catch (_) {
      return const PlayerProgress();
    }
  }

  Future<void> savePlayerProgress(PlayerProgress progress) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_keyCoins, progress.coins);
      await prefs.setInt(_keyCurrentLevel, progress.currentLevel);
      await prefs.setInt(_keyHighestUnlocked, progress.highestUnlockedLevel);
      await prefs.setInt(_keyTotalStars, progress.totalStars);
      await prefs.setInt(_keyHintCount, progress.hintCount);
      await prefs.setInt(_keyWordRevealCount, progress.wordRevealCount);
      await prefs.setInt(_keyCleanseCount, progress.cleanseCount);
      await prefs.setBool(_keySound, progress.soundEnabled);
      await prefs.setBool(_keyMusic, progress.musicEnabled);
      await prefs.setBool(_keyVibration, progress.vibrationEnabled);
      await prefs.setBool(_keyDailyClaimed, progress.dailyClaimed);
      await prefs.setString(_keyLanguage, progress.languageCode);
    } catch (_) {}
  }
}
