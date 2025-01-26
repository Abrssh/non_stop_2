part of 'artist_bloc.dart';

final class ArtistState extends Equatable {
  final List<Artist> artists;
  final bool isLoading;
  final bool isError;
  final String errorMessage;
  const ArtistState(
      {this.artists = const [],
      this.isLoading = false,
      this.isError = false,
      this.errorMessage = ''});

  ArtistState copyWith({
    List<Artist>? artists,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
  }) {
    return ArtistState(
      artists: artists ?? this.artists,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [artists, isLoading, isError, errorMessage];
}
