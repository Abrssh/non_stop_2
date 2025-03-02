import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:non_stop_2/Presentation/Widgets/custom_track_list.dart';
import 'package:non_stop_2/main.dart' as app;
import 'package:non_stop_2/Presentation/Pages/splash_screen.dart';
import 'package:non_stop_2/Presentation/Widgets/custom_album_widget.dart';
import 'package:non_stop_2/Presentation/Pages/album_tracks_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Album Page Navigation Flow Tests', () {
    testWidgets('Complete navigation flow to album tracks page',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await Future.delayed(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      // Verify we're on splash screen
      expect(find.byType(IntroScreen), findsOneWidget);

      // Tap the Start Listening button
      await tester.tap(find.text('Start Listening'));
      await tester.pumpAndSettle();

      // Tap the Album icon in bottom navigation (index 1)
      await tester.tap(find.byIcon(Icons.album));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 5));
      // Verify we're on album page
      expect(find.byType(AlbumGrid), findsOneWidget);

      // Select the first album
      await tester.tap(find.byType(CustomAlbumWidget).first);
      await tester.pumpAndSettle();

      // Verify we're on album tracks page
      expect(find.byType(AlbumTracksPage), findsOneWidget);
    });

    testWidgets('Album tracks page loads content correctly',
        (WidgetTester tester) async {
      // Launch and navigate to album tracks
      app.main();
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 5));
      await tester.tap(find.text('Start Listening'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.album));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 5));
      await tester.tap(find.byType(CustomAlbumWidget).first);
      await tester.pumpAndSettle();

      // Verify album tracks page content
      expect(find.byType(SliverAppBar), findsOneWidget);
      expect(find.byType(CustomTrackList), findsOneWidget);
      await Future.delayed(const Duration(seconds: 3));
    });
  });
}
