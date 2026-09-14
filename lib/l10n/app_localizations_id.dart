// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Word Archipelago';

  @override
  String get play => 'MAIN';

  @override
  String get continuePlaying => 'LANJUTKAN';

  @override
  String levelLabel(int number) {
    return 'Level $number';
  }

  @override
  String islandLevelHeader(int islandNum, int levelNum) {
    return 'Pulau $islandNum • Level $levelNum';
  }

  @override
  String get currentIsland => 'PULAU SAAT INI';

  @override
  String get crosswordPuzzle => 'Teka-Teki Silang';

  @override
  String get connectLetters => 'HUBUNGKAN HURUF';

  @override
  String get across => 'MENDATAR';

  @override
  String get down => 'MENURUN';

  @override
  String lettersCount(int count) {
    return '$count huruf';
  }

  @override
  String get dailyIslandGift => 'Hadiah Harian Pulau';

  @override
  String get dailyGiftDesc => 'Klaim petunjuk gratis & koin bonus setiap hari';

  @override
  String get dailyGiftClaimed => 'Sudah diklaim hari ini! Kembali lagi besok.';

  @override
  String get claim => 'Klaim';

  @override
  String get claimed => 'Diklaim';

  @override
  String get quickInventory => 'INVENTARIS CEPAT';

  @override
  String get hint => 'Petunjuk';

  @override
  String get wordReveal => 'Buka Kata';

  @override
  String get cleanse => 'Bersihkan';

  @override
  String get spectacular => 'LUAR BIASA!';

  @override
  String get levelCompleteSubtitle =>
      'Kamu berhasil menyelesaikan semua kata di teka-teki pulau ini!';

  @override
  String get nextLevel => 'LEVEL BERIKUTNYA';

  @override
  String watchDoubleReward(int coins) {
    return 'Tonton Video untuk Koin 2x (+$coins)';
  }

  @override
  String get replayLevel => 'Main Ulang Level';

  @override
  String get archipelagoShop => 'Toko Kepulauan';

  @override
  String get shopSubtitle =>
      'Dukung game dengan pembelian sekali dan paket bantuan';

  @override
  String get removeAds => 'Hapus Semua Iklan';

  @override
  String get removeAdsDesc =>
      'Pembelian permanen sekali bayar. Nikmati teka-teki silang tanpa iklan.';

  @override
  String get explorerBundle => 'Paket Penjelajah';

  @override
  String get explorerBundleDesc => '5 Petunjuk + 3 Buka Kata + 500 Koin';

  @override
  String get settings => 'Pengaturan';

  @override
  String get soundEffects => 'Efek Suara';

  @override
  String get music => 'Musik';

  @override
  String get hapticFeedback => 'Getaran Haptic';

  @override
  String get language => 'Bahasa';

  @override
  String get restorePurchases => 'Pulihkan Pembelian';

  @override
  String get islandsMap => 'Peta Kepulauan';

  @override
  String get zoneProgress => 'ZONA 1 DARI 6';

  @override
  String get archipelagoProgress => 'Kemajuan Kepulauan';

  @override
  String get locked => 'Terkunci';

  @override
  String get ready => 'Siap';

  @override
  String get nextUp => 'Selanjutnya';

  @override
  String get cleared => 'Selesai';

  @override
  String get mastered => 'Sempurna';

  @override
  String get needHelp => 'Butuh bantuan?';

  @override
  String rewardedAdPrompt(String reward) {
    return 'Tonton video sponsor singkat untuk mendapatkan $reward. Sepenuhnya opsional.';
  }

  @override
  String get watchVideo => 'TONTON VIDEO';

  @override
  String get noThanks => 'Lain kali';

  @override
  String get homeNav => 'Beranda';

  @override
  String get islandsNav => 'Kepulauan';

  @override
  String get shopNav => 'Toko';

  @override
  String get settingsNav => 'Pengaturan';

  @override
  String bonusWordFound(String word, int coins) {
    return 'Kata bonus \"$word\" (+$coins koin)!';
  }

  @override
  String alreadySolved(String word) {
    return 'Kata \"$word\" sudah terpecahkan!';
  }

  @override
  String wordSolved(String word) {
    return 'Berhasil: \"$word\"!';
  }

  @override
  String get notInPuzzle => 'Tidak ada dalam teka-teki';

  @override
  String get coins => 'Koin';

  @override
  String get freeLetterHint => '1 Petunjuk Gratis';
}
