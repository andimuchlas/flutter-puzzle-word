import 'package:flutter_test/flutter_test.dart';
import 'package:word_archipelago/main.dart';
import 'package:word_archipelago/features/gameplay/screens/gameplay_screen.dart';

void main() {
  testWidgets('WordArchipelagoApp smoke test and navigation to Gameplay',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const WordArchipelagoApp());
    await tester.pumpAndSettle();

    // Verify Home screen header & elements
    expect(find.text('WORD ARCHIPELAGO'), findsOneWidget);
    expect(find.text('CONTINUE'), findsOneWidget);
    expect(find.text('CURRENT ISLAND'), findsOneWidget);
    expect(find.text('Daily Island Gift'), findsOneWidget);

    // Tap CONTINUE button to open GameplayScreen
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();

    // Verify GameplayScreen is rendered
    expect(find.byType(GameplayScreen), findsOneWidget);
    expect(find.text('HUBUNGKAN HURUF'), findsOneWidget);
  });
}
