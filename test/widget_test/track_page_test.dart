import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:non_stop_2/Data/Model/track.dart';
import 'package:non_stop_2/Domain/bloc/track_bloc/track_bloc.dart';
import 'package:non_stop_2/Presentation/Pages/track_page.dart';
import 'package:non_stop_2/Presentation/Widgets/custom_track_card.dart';
import 'package:non_stop_2/Presentation/Widgets/custom_track_list.dart';

class MockTrackBloc extends MockBloc<TrackEvent, TrackState>
    implements TrackBloc {}

class FakeTrackEvent extends Fake implements SearchTracksEvent {}

class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return TestHttpClient();
  }
}

class TestHttpClient extends Fake implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async => TestHttpClientRequest();

  @override
  bool autoUncompress = true;
}

class TestHttpClientRequest extends Fake implements HttpClientRequest {
  @override
  Future<HttpClientResponse> close() async => TestHttpClientResponse();

  @override
  HttpHeaders get headers => TestHttpHeaders();
}

class TestHttpHeaders extends Fake implements HttpHeaders {
  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {}

  @override
  void removeAll(String name) {}
}

class TestHttpClientResponse extends Fake implements HttpClientResponse {
  @override
  int get statusCode => 200;

  @override
  int get contentLength => transparentImage.length;

  @override
  HttpHeaders get headers => TestHttpHeaders();

  Stream<List<int>> get content => Stream.value(transparentImage);

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;
  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return content.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}

// Add this transparent PNG image data
final transparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
]);

void main() {
  late MockTrackBloc mockTrackBloc;
  late List<Track> mockTracks;

  setUpAll(() {
    HttpOverrides.global = TestHttpOverrides();
    TestWidgetsFlutterBinding.ensureInitialized();
    registerFallbackValue(FakeTrackEvent());
    registerFallbackValue(const SearchedTracksState());
  });

  setUp(() {
    mockTrackBloc = MockTrackBloc();
    mockTracks = [
      Track(
        id: '1',
        name: 'Test Track 1',
        artistName: 'Artist 1',
        duration: 180,
        smallImageUrl: 'https://example.com/image1.jpg',
        largeImageUrl: 'https://example.com/image1.jpg',
        externalUrl: 'https://example.com/track1',
        date: DateTime.now().toString(),
      ),
    ];
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<TrackBloc>.value(
          value: mockTrackBloc,
          child: const TrackPage(height: 600),
        ),
      ),
    );
  }

  group('TrackPage Loading and Error Related Tests', () {
    testWidgets('shows loading indicator when state is loading',
        (tester) async {
      when(() => mockTrackBloc.state)
          .thenReturn(const SearchedTracksState(isLoading: true));

      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows track list when tracks are loaded', (tester) async {
      whenListen(
        mockTrackBloc,
        Stream<TrackState>.fromIterable([
          SearchedTracksState(tracks: mockTracks, isLoading: false),
        ]),
        initialState: SearchedTracksState(tracks: mockTracks, isLoading: false),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(CustomTrackCard), findsNWidgets(mockTracks.length));
    });

    testWidgets('shows error snackbar when error occurs', (tester) async {
      whenListen(
        mockTrackBloc,
        Stream<TrackState>.fromIterable([
          const SearchedTracksState(
            isError: true,
            errorMessage: 'Network Error',
            isLoading: false,
          ),
        ]),
        initialState: const SearchedTracksState(
          isError: false,
          errorMessage: '',
          isLoading: true,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle(); // Wait for SnackBar animation

      expect(find.text('Network Error'), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('transitions from loading to error state correctly',
        (tester) async {
      whenListen(
        mockTrackBloc,
        Stream<TrackState>.fromIterable([
          // const SearchedTracksState(isLoading: true), // have no effect
          const SearchedTracksState(
            isError: true,
            errorMessage: 'API Limit Exceeded',
            isLoading: false,
          ),
        ]),
        initialState: const SearchedTracksState(isLoading: true),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester
          .pumpAndSettle(); // Trigger the state change and wait for the animation to finish

      // await tester
      //     .pump(const Duration(milliseconds: 250)); // Wait for SnackBar animation manually

      expect(find.text('API Limit Exceeded'), findsOneWidget);
    });
  });

  group("Proper Track Page UI Behavior Tests", () {
    testWidgets('supports scrolling through track list', (tester) async {
      // Create enough tracks to make the list scrollable
      final manyTracks = List.generate(
          20,
          (index) => Track(
                id: 'id_$index',
                name: 'Track $index',
                artistName: 'Artist $index',
                duration: 180,
                smallImageUrl: 'https://example.com/image$index.jpg',
                largeImageUrl: 'https://example.com/image$index.jpg',
                externalUrl: 'https://example.com/track$index',
                date: DateTime.now().toString(),
              ));

      whenListen(
        mockTrackBloc,
        Stream<TrackState>.fromIterable([
          SearchedTracksState(tracks: manyTracks, isLoading: false),
        ]),
        initialState: SearchedTracksState(tracks: manyTracks, isLoading: false),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Verify initial visibility
      expect(find.text('Track 0'), findsOneWidget);
      expect(find.text('Track 10'), findsNothing);

      // Scroll to bottom
      await tester.dragFrom(
        tester.getCenter(find.byType(CustomTrackList)),
        const Offset(0, -500),
      );
      await tester.pumpAndSettle();

      // Verify scroll position
      expect(find.text('Track 0'), findsNothing);
      expect(find.text('Track 10'), findsOneWidget);
    });

    testWidgets('displays track names and artist names correctly',
        (tester) async {
      whenListen(
        mockTrackBloc,
        Stream<TrackState>.fromIterable([
          SearchedTracksState(tracks: mockTracks, isLoading: false),
        ]),
        initialState: SearchedTracksState(tracks: mockTracks, isLoading: false),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Test Track 1'), findsOneWidget);
      expect(find.text('Artist 1'), findsOneWidget);
    });

    testWidgets('handles empty track list gracefully', (tester) async {
      whenListen(
        mockTrackBloc,
        Stream<TrackState>.fromIterable([
          const SearchedTracksState(tracks: [], isLoading: false),
        ]),
        initialState: const SearchedTracksState(tracks: [], isLoading: false),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(CustomTrackCard), findsNothing);
    });

    testWidgets('handles long track names correctly', (tester) async {
      final tracksWithLongNames = [
        Track(
          id: '1',
          name: 'This is a very long track name that should be truncated',
          artistName:
              'This is a very long artist name that should be truncated',
          duration: 180,
          smallImageUrl: 'https://example.com/image1.jpg',
          largeImageUrl: 'https://example.com/image1.jpg',
          externalUrl: 'https://example.com/track1',
          date: DateTime.now().toString(),
        ),
      ];

      whenListen(
        mockTrackBloc,
        Stream<TrackState>.fromIterable([
          SearchedTracksState(tracks: tracksWithLongNames, isLoading: false),
        ]),
        initialState:
            SearchedTracksState(tracks: tracksWithLongNames, isLoading: false),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.textContaining('...'), findsWidgets);
    });
  });
}
