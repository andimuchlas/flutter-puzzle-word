import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/services/game_state.dart';
import 'core/theme/island_colors.dart';
import 'features/home/screens/home_screen.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: IslandColors.surface,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize offline persistent game state
  await GameState().init();

  runApp(const WordArchipelagoApp());
}

class WordArchipelagoApp extends StatelessWidget {
  const WordArchipelagoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: GameState(),
      builder: (context, _) {
        final gameState = GameState();

        return MaterialApp(
          title: 'Word Archipelago',
          debugShowCheckedModeBanner: false,
          locale: Locale(gameState.languageCode),
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
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: IslandColors.surface,
            colorScheme: ColorScheme.fromSeed(
              seedColor: IslandColors.primary,
              primary: IslandColors.primary,
              surface: IslandColors.surface,
            ),
            textTheme: GoogleFonts.plusJakartaSansTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}
