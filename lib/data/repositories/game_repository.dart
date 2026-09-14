import 'package:flutter/foundation.dart';
import '../../domain/models/player_progress.dart';
import '../services/storage_service.dart';

class GameRepository extends ChangeNotifier {
  final StorageService _storageService;

  PlayerProgress _progress = const PlayerProgress();
  bool _isInitialized = false;

  GameRepository({StorageService? storageService})
      : _storageService = storageService ?? StorageService();

  PlayerProgress get progress => _progress;
  bool get isInitialized => _isInitialized;

  int get coins => _progress.coins;
  int get currentLevel => _progress.currentLevel;
  int get highestUnlockedLevel => _progress.highestUnlockedLevel;
  int get totalStars => _progress.totalStars;
  int get hintCount => _progress.hintCount;
  int get wordRevealCount => _progress.wordRevealCount;
  int get cleanseCount => _progress.cleanseCount;
  bool get soundEnabled => _progress.soundEnabled;
  bool get musicEnabled => _progress.musicEnabled;
  bool get vibrationEnabled => _progress.vibrationEnabled;
  bool get dailyClaimed => _progress.dailyClaimed;
  String get languageCode => _progress.languageCode;

  Future<void> init() async {
    _progress = await _storageService.loadPlayerProgress();
    _isInitialized = true;
    notifyListeners();
  }

  void _update(PlayerProgress newProgress) {
    _progress = newProgress;
    notifyListeners();
    _storageService.savePlayerProgress(_progress);
  }

  void addCoins(int amount) {
    _update(_progress.copyWith(coins: _progress.coins + amount));
  }

  bool spendCoins(int amount) {
    if (_progress.coins >= amount) {
      _update(_progress.copyWith(coins: _progress.coins - amount));
      return true;
    }
    return false;
  }

  void setCurrentLevel(int level) {
    if (level <= _progress.highestUnlockedLevel) {
      _update(_progress.copyWith(currentLevel: level));
    }
  }

  void completeLevel(int levelNumber, int starsEarned, int rewardCoins) {
    final nextLevel = levelNumber + 1;
    final newHighest = nextLevel > _progress.highestUnlockedLevel
        ? nextLevel
        : _progress.highestUnlockedLevel;

    _update(_progress.copyWith(
      coins: _progress.coins + rewardCoins,
      totalStars: _progress.totalStars + starsEarned,
      currentLevel: nextLevel <= 5 ? nextLevel : levelNumber,
      highestUnlockedLevel: newHighest <= 5 ? newHighest : 5,
    ));
  }

  void claimDailyGift() {
    if (!_progress.dailyClaimed) {
      _update(_progress.copyWith(
        dailyClaimed: true,
        coins: _progress.coins + 100,
        hintCount: _progress.hintCount + 1,
      ));
    }
  }

  bool useLetterHint() {
    if (_progress.hintCount > 0) {
      _update(_progress.copyWith(hintCount: _progress.hintCount - 1));
      return true;
    } else if (spendCoins(50)) {
      return true;
    }
    return false;
  }

  bool useWordReveal() {
    if (_progress.wordRevealCount > 0) {
      _update(_progress.copyWith(wordRevealCount: _progress.wordRevealCount - 1));
      return true;
    } else if (spendCoins(100)) {
      return true;
    }
    return false;
  }

  bool useCleanse() {
    if (_progress.cleanseCount > 0) {
      _update(_progress.copyWith(cleanseCount: _progress.cleanseCount - 1));
      return true;
    } else if (spendCoins(30)) {
      return true;
    }
    return false;
  }

  void toggleSound() {
    _update(_progress.copyWith(soundEnabled: !_progress.soundEnabled));
  }

  void toggleMusic() {
    _update(_progress.copyWith(musicEnabled: !_progress.musicEnabled));
  }

  void toggleVibration() {
    _update(_progress.copyWith(vibrationEnabled: !_progress.vibrationEnabled));
  }

  void setLanguage(String code) {
    if (_progress.languageCode != code) {
      _update(_progress.copyWith(languageCode: code));
    }
  }
}
