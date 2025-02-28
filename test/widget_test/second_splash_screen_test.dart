import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:non_stop_2/Presentation/Pages/splash_screen.dart';

void main() {
  testWidgets('IntroScreen button press triggers navigation stub',
      (WidgetTester tester) async {
    // Create a flag to verify that our dummy route was requested.
    bool navigationCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        // Provide a dummy onGenerateRoute that just flips the flag.
        onGenerateRoute: (RouteSettings settings) {
          if (settings.name == '/home') {
            navigationCalled = true;
            return MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Center(child: Text('Dummy Home')),
              ),
            );
          }
          return null;
        },
        home: const IntroScreen(),
      ),
    );

    // Verify the button exists.
    final buttonFinder = find.byType(ElevatedButton);
    expect(buttonFinder, findsOneWidget);
    expect(find.text('Start Listening'), findsOneWidget);

    // Tap the button.
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    // Instead of checking navigation, we verify that our dummy route was requested.
    expect(navigationCalled, isTrue);
  });
}
