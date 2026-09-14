// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Word Archipelago';

  @override
  String get play => 'PLAY';

  @override
  String get continuePlaying => 'CONTINUE';

  @override
  String levelLabel(int number) {
    return 'Level $number';
  }

  @override
  String islandLevelHeader(int islandNum, int levelNum) {
    return 'Island $islandNum • Level $levelNum';
  }

  @override
  String get currentIsland => 'CURRENT ISLAND';

  @override
  String get crosswordPuzzle => 'Crossword Puzzle';

  @override
  String get connectLetters => 'CONNECT LETTERS';

  @override
  String get across => 'ACROSS';

  @override
  String get down => 'DOWN';

  @override
  String lettersCount(int count) {
    return '$count letters';
  }

  @override
  String get dailyIslandGift => 'Daily Island Gift';

  @override
  String get dailyGiftDesc => 'Claim free hints & bonus coins every day';

  @override
  String get dailyGiftClaimed => 'Claimed for today! Come back tomorrow.';

  @override
  String get claim => 'Claim';

  @override
  String get claimed => 'Claimed';

  @override
  String get quickInventory => 'QUICK INVENTORY';

  @override
  String get hint => 'Hint';

  @override
  String get wordReveal => 'Word Reveal';

  @override
  String get cleanse => 'Cleanse';

  @override
  String get spectacular => 'SPECTACULAR!';

  @override
  String get levelCompleteSubtitle =>
      'You solved all words in this island puzzle!';

  @override
  String get nextLevel => 'NEXT LEVEL';

  @override
  String watchDoubleReward(int coins) {
    return 'Watch Video for 2x Coins (+$coins)';
  }

  @override
  String get replayLevel => 'Replay Level';

  @override
  String get archipelagoShop => 'Archipelago Shop';

  @override
  String get shopSubtitle =>
      'Support the game with one-time purchases and powerup bundles';

  @override
  String get removeAds => 'Remove All Ads';

  @override
  String get removeAdsDesc =>
      'Permanent one-time purchase. Enjoy ad-free crossword solving.';

  @override
  String get explorerBundle => 'Explorer Bundle';

  @override
  String get explorerBundleDesc => '5 Hints + 3 Word Reveals + 500 Coins';

  @override
  String get settings => 'Settings';

  @override
  String get soundEffects => 'Sound Effects';

  @override
  String get music => 'Music';

  @override
  String get hapticFeedback => 'Haptic Feedback';

  @override
  String get language => 'Language';

  @override
  String get restorePurchases => 'Restore Purchases';

  @override
  String get islandsMap => 'Islands Map';

  @override
  String get zoneProgress => 'ZONE 1 OF 6';

  @override
  String get archipelagoProgress => 'Archipelago Progress';

  @override
  String get locked => 'Locked';

  @override
  String get ready => 'Ready';

  @override
  String get nextUp => 'Next Up';

  @override
  String get cleared => 'Cleared';

  @override
  String get mastered => 'Mastered';

  @override
  String get needHelp => 'Need a little help?';

  @override
  String rewardedAdPrompt(String reward) {
    return 'Watch a short video sponsor to receive $reward. Completely optional.';
  }

  @override
  String get watchVideo => 'WATCH VIDEO';

  @override
  String get noThanks => 'No thanks';

  @override
  String get homeNav => 'Home';

  @override
  String get islandsNav => 'Islands';

  @override
  String get shopNav => 'Shop';

  @override
  String get settingsNav => 'Settings';

  @override
  String bonusWordFound(String word, int coins) {
    return 'Bonus word \"$word\" (+$coins coins)!';
  }

  @override
  String alreadySolved(String word) {
    return 'Already solved \"$word\"!';
  }

  @override
  String wordSolved(String word) {
    return 'Solved \"$word\"!';
  }

  @override
  String get notInPuzzle => 'Not in puzzle';

  @override
  String get coins => 'Coins';

  @override
  String get freeLetterHint => '1 Free Hint';
}
