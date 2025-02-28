import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:non_stop_2/Presentation/Pages/splash_screen.dart';

void main() {
  testWidgets('IntroScreen widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: IntroScreen(),
      ),
    );

    // Verify background image and gradient containers exist
    expect(find.byType(Container), findsNWidgets(2));

    // Wont work because of the RichText widget
    // expect(
    //     find.text("Nonstop Ethiopia.\n", findRichText: true), findsNWidgets(1));

    // Verify "Nonstop Ethiopia" text exists within the RichText
    expect(find.byWidgetPredicate((Widget widget) {
      if (widget is RichText) {
        final text = widget.text;
        if (text is TextSpan) {
          return text.toPlainText().contains('Nonstop Ethiopia.');
        }
      }
      return false;
    }), findsOneWidget);

    // Verify start listening button exists
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Start Listening'), findsOneWidget);
  });
}
