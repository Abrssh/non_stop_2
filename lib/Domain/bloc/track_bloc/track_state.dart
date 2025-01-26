part of 'track_bloc.dart';

sealed class TrackState extends Equatable {
  final List<Track> tracks;
  final bool isLoading;
  final bool isError;
  final String errorMessage;

  const TrackState(
      {this.tracks = const [],
      this.isLoading = false,
      this.errorMessage = "",
      this.isError = false});

  TrackState copyWith({
    List<Track>? tracks,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
  });

  @override
  List<Object> get props => [tracks, isLoading, isError, errorMessage];
}

final class SearchedTracksState extends TrackState {
  const SearchedTracksState(
      {List<Track> tracks = const [],
      bool isLoading = false,
      String errorMessage = "",
      bool isError = false})
      : super(
            tracks: tracks,
            isLoading: isLoading,
            errorMessage: errorMessage,
            isError: isError);

  @override
  TrackState copyWith(
      {List<Track>? tracks,
      bool? isLoading,
      bool? isError,
      String? errorMessage}) {
    return SearchedTracksState(
        tracks: tracks ?? this.tracks,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        isError: isError ?? this.isError);
  }
}

final class AlbumTracksState extends TrackState {
  const AlbumTracksState(
      {List<Track> tracks = const [],
      bool isLoading = false,
      String errorMessage = "",
      bool isError = false})
      : super(
            tracks: tracks,
            isLoading: isLoading,
            errorMessage: errorMessage,
            isError: isError);

  @override
  TrackState copyWith(
      {List<Track>? tracks,
      bool? isLoading,
      bool? isError,
      String? errorMessage}) {
    return AlbumTracksState(
        tracks: tracks ?? this.tracks,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        isError: isError ?? this.isError);
  }
}
