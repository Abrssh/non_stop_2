import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:non_stop_2/Data/Model/artist.dart';
import 'package:non_stop_2/Domain/Interface/get_artists_usecase.dart';
import 'package:non_stop_2/Domain/bloc/artist_bloc/artist_bloc.dart';

class MockGetArtistsUseCase extends Mock implements GetArtistsUseCase {}

class MockHydratedStorage extends Mock implements HydratedStorage {
  @override
  Future<void> write(String key, dynamic value) async {
    debugPrint("MockHydratedStorage write called");
  }

  @override
  read(String key) {
    debugPrint("MockHydratedStorage read called");
  }
}

void main() {
  final mockGetArtistsUseCase = MockGetArtistsUseCase();
  final mockHydratedStorage = MockHydratedStorage();

  setUp(() {
    HydratedBloc.storage = mockHydratedStorage;
    debugPrint("Hydrated Bloc Storage: ${HydratedBloc.storage}");
  });

  tearDown(() {
    HydratedBloc.storage = null;
  });

  group("Artist Bloc Tests", () {
    blocTest<ArtistBloc, ArtistState>(
      'Fetch Artists Successfully',
      setUp: () {
        when(() => mockGetArtistsUseCase.getArtists())
            .thenAnswer((_) async => await Future.value([
                  const Artist(
                    id: "1",
                    name: "Artist 1",
                    largeImageUrl: "",
                    smallImageUrl: "",
                  ),
                ]));
      },
      build: () => ArtistBloc(getArtistsUseCase: mockGetArtistsUseCase),
      // act: (bloc) => bloc.add(const GetArtistsEvent()),
      act: (bloc) => debugPrint("Nothing is acted here"),
      expect: () => <ArtistState>[
        const ArtistState(
            artists: [], isLoading: true, isError: false, isIntial: false),
        const ArtistState(artists: [
          Artist(
            id: "1",
            name: "Artist 1",
            largeImageUrl: "",
            smallImageUrl: "",
          ),
        ], isLoading: false, isError: false, isIntial: false),
      ],
    );

    blocTest<ArtistBloc, ArtistState>(
      'Return Appropriate Error when it fails',
      build: () => ArtistBloc(getArtistsUseCase: mockGetArtistsUseCase),
      act: (bloc) => debugPrint("Nothing is acted here"),
      setUp: () {
        when(() => mockGetArtistsUseCase.getArtists()).thenAnswer(
            (_) async => throw Exception("Failed to fetch artists"));
      },
      expect: () => const <ArtistState>[
        ArtistState(
            artists: [], isLoading: true, isError: false, isIntial: false),
        ArtistState(
            artists: [],
            isLoading: false,
            isError: true,
            errorMessage: "Exception: Failed to fetch artists",
            isIntial: false),
      ],
    );
  });
}
