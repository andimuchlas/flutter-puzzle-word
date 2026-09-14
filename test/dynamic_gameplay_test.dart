import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_archipelago/core/services/game_state.dart';
import 'package:word_archipelago/domain/models/puzzle_level.dart';
import 'package:word_archipelago/features/gameplay/screens/gameplay_screen.dart';
import 'package:word_archipelago/features/gameplay/widgets/crossword_grid_widget.dart';
import 'package:word_archipelago/features/gameplay/widgets/island_scenic_background.dart';
import 'package:word_archipelago/features/gameplay/widgets/letter_wheel/letter_wheel_widget.dart';
import 'package:word_archipelago/l10n/app_localizations.dart';
import 'package:word_archipelago/main.dart';

import 'package:shared_preferences/shared_preferences.dart';

Widget _buildTestApp(Widget home) {
  return MaterialApp(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en'),
      Locale('id'),
    ],
    home: home,
  );
}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await GameState().init();
    GameState().setLanguage('id');
  });

  group('Dynamic Gameplay & Localization Tests', () {
    testWidgets('Renders dynamic grid for each of the 5 levels without layout errors',
        (WidgetTester tester) async {
      for (int lvl = 1; lvl <= 5; lvl++) {
        final puzzleLevel = PuzzleLevel.getLevel(lvl);

        await tester.pumpWidget(_buildTestApp(GameplayScreen(level: puzzleLevel)));
        await tester.pumpAndSettle();

        expect(find.byType(CrosswordGridWidget), findsOneWidget);
        expect(find.byType(LetterWheelWidget), findsOneWidget);
        expect(find.byType(IslandScenicBackground), findsOneWidget);
        expect(find.textContaining('Level $lvl'), findsWidgets);
      }
    });

    testWidgets('Bilingual language toggle updates strings to Indonesian and English',
        (WidgetTester tester) async {
      await tester.pumpWidget(const WordArchipelagoApp());
      await tester.pumpAndSettle();

      // Initially Indonesian
      expect(find.text('LANJUTKAN'), findsOneWidget);
      expect(find.text('PULAU SAAT INI'), findsOneWidget);

      // Switch language to English
      GameState().setLanguage('en');
      await tester.pumpAndSettle();

      // Expect English UI
      expect(find.text('CONTINUE'), findsOneWidget);

      // Switch back to Indonesian
      GameState().setLanguage('id');
      await tester.pumpAndSettle();
      expect(find.text('LANJUTKAN'), findsOneWidget);
    });

    testWidgets('Letter Wheel connects letters and submits Nusantara word on Level 1',
        (WidgetTester tester) async {
      final level1 = PuzzleLevel.getLevel(1);

      await tester.pumpWidget(_buildTestApp(GameplayScreen(level: level1)));
      await tester.pumpAndSettle();

      final letterWheel = tester.widget<LetterWheelWidget>(find.byType(LetterWheelWidget));
      expect(letterWheel.letters.contains('P'), isTrue);
      expect(letterWheel.letters.contains('A'), isTrue);
      expect(letterWheel.letters.contains('N'), isTrue);
      expect(letterWheel.letters.contains('T'), isTrue);
      expect(letterWheel.letters.contains('I'), isTrue);

      // Submit correct Nusantara word "PANTAI"
      letterWheel.onWordSubmitted('PANTAI');
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // After submitting PANTAI, letters 'P', 'A', 'N', 'T', 'I' are revealed in the grid
      expect(find.text('P'), findsWidgets);
      expect(find.text('N'), findsWidgets);
      expect(find.text('T'), findsWidgets);
    });

    testWidgets('Gameplay screen fits mobile viewport without SingleChildScrollView or overflow', (tester) async {
      // Standard mobile phone screen size (390 x 844)
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        _buildTestApp(const GameplayScreen()),
      );
      await tester.pumpAndSettle();

      // Ensure no SingleChildScrollView exists on phone layout
      expect(find.byType(SingleChildScrollView), findsNothing);

      // Verify that all core Wordscapes elements are rendered and visible on screen
      expect(find.byType(IslandScenicBackground), findsOneWidget);
      expect(find.byType(CrosswordGridWidget), findsOneWidget);
      expect(find.byType(LetterWheelWidget), findsOneWidget);

      // Ensure no layout overflow errors were recorded
      expect(tester.takeException(), isNull);
    });
  });
}
