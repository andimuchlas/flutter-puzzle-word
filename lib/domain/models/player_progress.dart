class PlayerProgress {
  final int coins;
  final int currentLevel;
  final int highestUnlockedLevel;
  final int totalStars;
  final int hintCount;
  final int wordRevealCount;
  final int cleanseCount;
  final bool soundEnabled;
  final bool musicEnabled;
  final bool vibrationEnabled;
  final bool dailyClaimed;
  final String languageCode;

  const PlayerProgress({
    this.coins = 1450,
    this.currentLevel = 1,
    this.highestUnlockedLevel = 1,
    this.totalStars = 0,
    this.hintCount = 4,
    this.wordRevealCount = 2,
    this.cleanseCount = 5,
    this.soundEnabled = true,
    this.musicEnabled = true,
    this.vibrationEnabled = true,
    this.dailyClaimed = false,
    this.languageCode = 'id',
  });

  PlayerProgress copyWith({
    int? coins,
    int? currentLevel,
    int? highestUnlockedLevel,
    int? totalStars,
    int? hintCount,
    int? wordRevealCount,
    int? cleanseCount,
    bool? soundEnabled,
    bool? musicEnabled,
    bool? vibrationEnabled,
    bool? dailyClaimed,
    String? languageCode,
  }) {
    return PlayerProgress(
      coins: coins ?? this.coins,
      currentLevel: currentLevel ?? this.currentLevel,
      highestUnlockedLevel: highestUnlockedLevel ?? this.highestUnlockedLevel,
      totalStars: totalStars ?? this.totalStars,
      hintCount: hintCount ?? this.hintCount,
      wordRevealCount: wordRevealCount ?? this.wordRevealCount,
      cleanseCount: cleanseCount ?? this.cleanseCount,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      musicEnabled: musicEnabled ?? this.musicEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      dailyClaimed: dailyClaimed ?? this.dailyClaimed,
      languageCode: languageCode ?? this.languageCode,
    );
  }
}
