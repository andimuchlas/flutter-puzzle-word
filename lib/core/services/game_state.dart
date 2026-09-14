import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameState extends ChangeNotifier {
  static final GameState _instance = GameState._internal();
  factory GameState() => _instance;
  GameState._internal();

  int _coins = 1450;
  int _currentLevel = 12;
  int _totalStars = 48;
  int _hintCount = 4;
  int _wordRevealCount = 2;
  int _cleanseCount = 5;
  bool _soundEnabled = true;
  bool _musicEnabled = true;
  bool _vibrationEnabled = true;
  bool _dailyClaimed = false;

  int get coins => _coins;
  int get currentLevel => _currentLevel;
  int get totalStars => _totalStars;
  int get hintCount => _hintCount;
  int get wordRevealCount => _wordRevealCount;
  int get cleanseCount => _cleanseCount;
  bool get soundEnabled => _soundEnabled;
  bool get musicEnabled => _musicEnabled;
  bool get vibrationEnabled => _vibrationEnabled;
  bool get dailyClaimed => _dailyClaimed;

  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _coins = prefs.getInt('coins') ?? 1450;
      _currentLevel = prefs.getInt('currentLevel') ?? 12;
      _totalStars = prefs.getInt('totalStars') ?? 48;
      _hintCount = prefs.getInt('hintCount') ?? 4;
      _wordRevealCount = prefs.getInt('wordRevealCount') ?? 2;
      _cleanseCount = prefs.getInt('cleanseCount') ?? 5;
      _soundEnabled = prefs.getBool('soundEnabled') ?? true;
      _musicEnabled = prefs.getBool('musicEnabled') ?? true;
      _vibrationEnabled = prefs.getBool('vibrationEnabled') ?? true;
      _dailyClaimed = prefs.getBool('dailyClaimed') ?? false;
      notifyListeners();
    } catch (_) {}
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('coins', _coins);
      await prefs.setInt('currentLevel', _currentLevel);
      await prefs.setInt('totalStars', _totalStars);
      await prefs.setInt('hintCount', _hintCount);
      await prefs.setInt('wordRevealCount', _wordRevealCount);
      await prefs.setInt('cleanseCount', _cleanseCount);
      await prefs.setBool('soundEnabled', _soundEnabled);
      await prefs.setBool('musicEnabled', _musicEnabled);
      await prefs.setBool('vibrationEnabled', _vibrationEnabled);
      await prefs.setBool('dailyClaimed', _dailyClaimed);
    } catch (_) {}
  }

  void addCoins(int amount) {
    _coins += amount;
    notifyListeners();
    _save();
  }

  bool spendCoins(int amount) {
    if (_coins >= amount) {
      _coins -= amount;
      notifyListeners();
      _save();
      return true;
    }
    return false;
  }

  void completeCurrentLevel(int starsEarned, int rewardCoins) {
    _totalStars += starsEarned;
    _coins += rewardCoins;
    _currentLevel++;
    notifyListeners();
    _save();
  }

  void claimDailyGift() {
    if (!_dailyClaimed) {
      _dailyClaimed = true;
      _coins += 100;
      _hintCount += 1;
      notifyListeners();
      _save();
    }
  }

  bool useHint() {
    if (_hintCount > 0) {
      _hintCount--;
      notifyListeners();
      _save();
      return true;
    } else if (spendCoins(50)) {
      return true;
    }
    return false;
  }

  bool useWordReveal() {
    if (_wordRevealCount > 0) {
      _wordRevealCount--;
      notifyListeners();
      _save();
      return true;
    } else if (spendCoins(100)) {
      return true;
    }
    return false;
  }

  bool useCleanse() {
    if (_cleanseCount > 0) {
      _cleanseCount--;
      notifyListeners();
      _save();
      return true;
    } else if (spendCoins(30)) {
      return true;
    }
    return false;
  }

  void toggleSound() {
    _soundEnabled = !_soundEnabled;
    notifyListeners();
    _save();
  }

  void toggleMusic() {
    _musicEnabled = !_musicEnabled;
    notifyListeners();
    _save();
  }

  void toggleVibration() {
    _vibrationEnabled = !_vibrationEnabled;
    notifyListeners();
    _save();
  }
}
