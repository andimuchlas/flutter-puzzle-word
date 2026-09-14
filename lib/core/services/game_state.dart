import 'package:flutter/foundation.dart';
import '../../data/repositories/game_repository.dart';
import '../../data/services/storage_service.dart';

/// Facade for GameRepository preserving backward compatibility
class GameState extends ChangeNotifier {
  static final GameState _instance = GameState._internal();
  factory GameState() => _instance;
  GameState._internal() {
    _repository = GameRepository(storageService: StorageService());
    _repository.addListener(notifyListeners);
  }

  late final GameRepository _repository;
  GameRepository get repository => _repository;

  int get coins => _repository.coins;
  int get currentLevel => _repository.currentLevel;
  int get highestUnlockedLevel => _repository.highestUnlockedLevel;
  int get totalStars => _repository.totalStars;
  int get hintCount => _repository.hintCount;
  int get wordRevealCount => _repository.wordRevealCount;
  int get cleanseCount => _repository.cleanseCount;
  bool get soundEnabled => _repository.soundEnabled;
  bool get musicEnabled => _repository.musicEnabled;
  bool get vibrationEnabled => _repository.vibrationEnabled;
  bool get dailyClaimed => _repository.dailyClaimed;
  String get languageCode => _repository.languageCode;

  Future<void> init() async {
    await _repository.init();
  }

  void addCoins(int amount) => _repository.addCoins(amount);
  bool spendCoins(int amount) => _repository.spendCoins(amount);
  void setCurrentLevel(int level) => _repository.setCurrentLevel(level);
  void completeCurrentLevel(int starsEarned, int rewardCoins) =>
      _repository.completeLevel(_repository.currentLevel, starsEarned, rewardCoins);
  void claimDailyGift() => _repository.claimDailyGift();
  bool useHint() => _repository.useLetterHint();
  bool useWordReveal() => _repository.useWordReveal();
  bool useCleanse() => _repository.useCleanse();
  void toggleSound() => _repository.toggleSound();
  void toggleMusic() => _repository.toggleMusic();
  void toggleVibration() => _repository.toggleVibration();
  void setLanguage(String code) => _repository.setLanguage(code);
}
