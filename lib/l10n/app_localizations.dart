import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Word Archipelago'**
  String get appTitle;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'PLAY'**
  String get play;

  /// No description provided for @continuePlaying.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE'**
  String get continuePlaying;

  /// No description provided for @levelLabel.
  ///
  /// In en, this message translates to:
  /// **'Level {number}'**
  String levelLabel(int number);

  /// No description provided for @islandLevelHeader.
  ///
  /// In en, this message translates to:
  /// **'Island {islandNum} • Level {levelNum}'**
  String islandLevelHeader(int islandNum, int levelNum);

  /// No description provided for @currentIsland.
  ///
  /// In en, this message translates to:
  /// **'CURRENT ISLAND'**
  String get currentIsland;

  /// No description provided for @crosswordPuzzle.
  ///
  /// In en, this message translates to:
  /// **'Crossword Puzzle'**
  String get crosswordPuzzle;

  /// No description provided for @connectLetters.
  ///
  /// In en, this message translates to:
  /// **'CONNECT LETTERS'**
  String get connectLetters;

  /// No description provided for @across.
  ///
  /// In en, this message translates to:
  /// **'ACROSS'**
  String get across;

  /// No description provided for @down.
  ///
  /// In en, this message translates to:
  /// **'DOWN'**
  String get down;

  /// No description provided for @lettersCount.
  ///
  /// In en, this message translates to:
  /// **'{count} letters'**
  String lettersCount(int count);

  /// No description provided for @dailyIslandGift.
  ///
  /// In en, this message translates to:
  /// **'Daily Island Gift'**
  String get dailyIslandGift;

  /// No description provided for @dailyGiftDesc.
  ///
  /// In en, this message translates to:
  /// **'Claim free hints & bonus coins every day'**
  String get dailyGiftDesc;

  /// No description provided for @dailyGiftClaimed.
  ///
  /// In en, this message translates to:
  /// **'Claimed for today! Come back tomorrow.'**
  String get dailyGiftClaimed;

  /// No description provided for @claim.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get claim;

  /// No description provided for @claimed.
  ///
  /// In en, this message translates to:
  /// **'Claimed'**
  String get claimed;

  /// No description provided for @quickInventory.
  ///
  /// In en, this message translates to:
  /// **'QUICK INVENTORY'**
  String get quickInventory;

  /// No description provided for @hint.
  ///
  /// In en, this message translates to:
  /// **'Hint'**
  String get hint;

  /// No description provided for @wordReveal.
  ///
  /// In en, this message translates to:
  /// **'Word Reveal'**
  String get wordReveal;

  /// No description provided for @cleanse.
  ///
  /// In en, this message translates to:
  /// **'Cleanse'**
  String get cleanse;

  /// No description provided for @spectacular.
  ///
  /// In en, this message translates to:
  /// **'SPECTACULAR!'**
  String get spectacular;

  /// No description provided for @levelCompleteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You solved all words in this island puzzle!'**
  String get levelCompleteSubtitle;

  /// No description provided for @nextLevel.
  ///
  /// In en, this message translates to:
  /// **'NEXT LEVEL'**
  String get nextLevel;

  /// No description provided for @watchDoubleReward.
  ///
  /// In en, this message translates to:
  /// **'Watch Video for 2x Coins (+{coins})'**
  String watchDoubleReward(int coins);

  /// No description provided for @replayLevel.
  ///
  /// In en, this message translates to:
  /// **'Replay Level'**
  String get replayLevel;

  /// No description provided for @archipelagoShop.
  ///
  /// In en, this message translates to:
  /// **'Archipelago Shop'**
  String get archipelagoShop;

  /// No description provided for @shopSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Support the game with one-time purchases and powerup bundles'**
  String get shopSubtitle;

  /// No description provided for @removeAds.
  ///
  /// In en, this message translates to:
  /// **'Remove All Ads'**
  String get removeAds;

  /// No description provided for @removeAdsDesc.
  ///
  /// In en, this message translates to:
  /// **'Permanent one-time purchase. Enjoy ad-free crossword solving.'**
  String get removeAdsDesc;

  /// No description provided for @explorerBundle.
  ///
  /// In en, this message translates to:
  /// **'Explorer Bundle'**
  String get explorerBundle;

  /// No description provided for @explorerBundleDesc.
  ///
  /// In en, this message translates to:
  /// **'5 Hints + 3 Word Reveals + 500 Coins'**
  String get explorerBundleDesc;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @soundEffects.
  ///
  /// In en, this message translates to:
  /// **'Sound Effects'**
  String get soundEffects;

  /// No description provided for @music.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  /// No description provided for @hapticFeedback.
  ///
  /// In en, this message translates to:
  /// **'Haptic Feedback'**
  String get hapticFeedback;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restorePurchases;

  /// No description provided for @islandsMap.
  ///
  /// In en, this message translates to:
  /// **'Islands Map'**
  String get islandsMap;

  /// No description provided for @zoneProgress.
  ///
  /// In en, this message translates to:
  /// **'ZONE 1 OF 6'**
  String get zoneProgress;

  /// No description provided for @archipelagoProgress.
  ///
  /// In en, this message translates to:
  /// **'Archipelago Progress'**
  String get archipelagoProgress;

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get locked;

  /// No description provided for @ready.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get ready;

  /// No description provided for @nextUp.
  ///
  /// In en, this message translates to:
  /// **'Next Up'**
  String get nextUp;

  /// No description provided for @cleared.
  ///
  /// In en, this message translates to:
  /// **'Cleared'**
  String get cleared;

  /// No description provided for @mastered.
  ///
  /// In en, this message translates to:
  /// **'Mastered'**
  String get mastered;

  /// No description provided for @needHelp.
  ///
  /// In en, this message translates to:
  /// **'Need a little help?'**
  String get needHelp;

  /// No description provided for @rewardedAdPrompt.
  ///
  /// In en, this message translates to:
  /// **'Watch a short video sponsor to receive {reward}. Completely optional.'**
  String rewardedAdPrompt(String reward);

  /// No description provided for @watchVideo.
  ///
  /// In en, this message translates to:
  /// **'WATCH VIDEO'**
  String get watchVideo;

  /// No description provided for @noThanks.
  ///
  /// In en, this message translates to:
  /// **'No thanks'**
  String get noThanks;

  /// No description provided for @homeNav.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeNav;

  /// No description provided for @islandsNav.
  ///
  /// In en, this message translates to:
  /// **'Islands'**
  String get islandsNav;

  /// No description provided for @shopNav.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shopNav;

  /// No description provided for @settingsNav.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsNav;

  /// No description provided for @bonusWordFound.
  ///
  /// In en, this message translates to:
  /// **'Bonus word \"{word}\" (+{coins} coins)!'**
  String bonusWordFound(String word, int coins);

  /// No description provided for @alreadySolved.
  ///
  /// In en, this message translates to:
  /// **'Already solved \"{word}\"!'**
  String alreadySolved(String word);

  /// No description provided for @wordSolved.
  ///
  /// In en, this message translates to:
  /// **'Solved \"{word}\"!'**
  String wordSolved(String word);

  /// No description provided for @notInPuzzle.
  ///
  /// In en, this message translates to:
  /// **'Not in puzzle'**
  String get notInPuzzle;

  /// No description provided for @coins.
  ///
  /// In en, this message translates to:
  /// **'Coins'**
  String get coins;

  /// No description provided for @freeLetterHint.
  ///
  /// In en, this message translates to:
  /// **'1 Free Hint'**
  String get freeLetterHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
