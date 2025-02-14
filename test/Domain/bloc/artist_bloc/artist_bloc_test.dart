import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:non_stop_2/Data/Model/artist.dart';
import 'package:non_stop_2/Domain/Interface/get_artists_usecase.dart';
import 'package:non_stop_2/Domain/bloc/artist_bloc/artist_bloc.dart';

class MockGetArtistsUseCase extends Mock implements GetArtistsUseCase {}

void main() {
  MockGetArtistsUseCase mockGetArtistsUseCase = MockGetArtistsUseCase();

  group("Artist Bloc Tests", () {
    blocTest<ArtistBloc, ArtistState>(
      'Fetch Artists Successfully',
      build: () => ArtistBloc(getArtistsUseCase: mockGetArtistsUseCase),
      act: (bloc) => bloc.add(const GetArtistsEvent()),
      setUp: () {
        when(() => mockGetArtistsUseCase.getArtists()).thenAnswer((_) async => [
              Artist(
                id: "1",
                name: "Artist 1",
                largeImageUrl: "",
                smallImageUrl: "",
              ),
            ]);
      },
      verify: (bloc) =>
          verify(() => mockGetArtistsUseCase.getArtists()).called(1),
      expect: () => const <ArtistState>[
        ArtistState(
          artists: [],
          isLoading: true,
          isError: false,
        ),
        ArtistState(
          artists: [],
          isLoading: false,
          isError: false,
        ),
      ],
    );
    blocTest<ArtistBloc, ArtistState>(
      'Return Appropriate Error when it fails',
      build: () => ArtistBloc(getArtistsUseCase: mockGetArtistsUseCase),
      act: (bloc) => bloc.add(const GetArtistsEvent()),
      setUp: () {
        when(() => mockGetArtistsUseCase.getArtists()).thenAnswer(
            (_) async => throw Exception("Failed to fetch artists"));
      },
      verify: (bloc) {
        verify(() =>
            bloc.state.isError == true &&
            bloc.state.errorMessage == "Failed to fetch artists");
      },
      expect: () => const <ArtistState>[
        ArtistState(
          artists: [],
          isLoading: true,
          isError: false,
        ),
        ArtistState(
          artists: [],
          isLoading: false,
          isError: false,
        ),
      ],
    );
  });
}
