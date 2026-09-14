import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:word_archipelago/features/gameplay/screens/gameplay_screen.dart';
import 'package:word_archipelago/features/gameplay/widgets/crossword_grid_widget.dart';
import 'package:word_archipelago/features/gameplay/widgets/letter_wheel/letter_wheel_widget.dart';
import 'package:word_archipelago/main.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('WordArchipelagoApp smoke test and navigation to Gameplay',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const WordArchipelagoApp());
    await tester.pumpAndSettle();

    // Verify Home screen header & elements (Indonesian by default)
    expect(find.text('WORD ARCHIPELAGO'), findsOneWidget);
    expect(find.text('LANJUTKAN'), findsOneWidget);
    expect(find.text('PULAU SAAT INI'), findsOneWidget);
    expect(find.text('Hadiah Harian Pulau'), findsOneWidget);
    expect(find.text('SELECT LEVEL'), findsOneWidget);

    // Tap LANJUTKAN button to open GameplayScreen
    await tester.tap(find.text('LANJUTKAN'));
    await tester.pumpAndSettle();

    // Verify GameplayScreen is rendered with letter wheel & crossword grid
    expect(find.byType(GameplayScreen), findsOneWidget);
    expect(find.byType(CrosswordGridWidget), findsOneWidget);
    expect(find.byType(LetterWheelWidget), findsOneWidget);
  });
}
