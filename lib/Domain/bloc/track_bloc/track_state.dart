part of 'track_bloc.dart';

sealed class TrackState extends Equatable {
  final List<Track> tracks;
  final List<Track> albumTracks;
  final List<Track> topTracks;
  final bool isIntial;
  final bool isLoading;
  final bool isError;
  final String errorMessage;

  const TrackState(
      {this.tracks = const [],
      this.albumTracks = const [],
      this.topTracks = const [],
      this.isIntial = false,
      this.isLoading = false,
      this.errorMessage = "",
      this.isError = false});

  TrackState copyWith({
    List<Track>? tracks,
    List<Track>? albumTracks,
    List<Track>? topTracks,
    bool? isIntial,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
  });

  @override
  List<Object> get props => [
        tracks,
        albumTracks,
        topTracks,
        isLoading,
        isIntial,
        isError,
        errorMessage
      ];
}

final class SearchedTracksState extends TrackState {
  const SearchedTracksState(
      {List<Track> tracks = const [],
      List<Track> albumTracks = const [],
      List<Track> topTracks = const [],
      bool isIntial = false,
      bool isLoading = false,
      String errorMessage = "",
      bool isError = false})
      : super(
            tracks: tracks,
            albumTracks: albumTracks,
            topTracks: topTracks,
            isIntial: isIntial,
            isLoading: isLoading,
            errorMessage: errorMessage,
            isError: isError);

  @override
  TrackState copyWith(
      {List<Track>? tracks,
      List<Track>? albumTracks,
      List<Track>? topTracks,
      bool? isIntial,
      bool? isLoading,
      bool? isError,
      String? errorMessage}) {
    return SearchedTracksState(
        tracks: tracks ?? this.tracks,
        albumTracks: albumTracks ?? this.albumTracks,
        topTracks: topTracks ?? this.topTracks,
        isIntial: isIntial ?? this.isIntial,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        isError: isError ?? this.isError);
  }

  Map<String, dynamic> toJson() {
    return {
      'tracks': tracks.map((track) => track.toMap()).toList(),
      'albumTracks': albumTracks.map((track) => track.toMap()).toList(),
      'topTracks': topTracks.map((track) => track.toMap()).toList(),
      'isIntial': isIntial,
      'isLoading': isLoading,
      'errorMessage': errorMessage,
      'isError': isError,
    };
  }

  factory SearchedTracksState.fromJson(Map<String, dynamic> map) {
    return SearchedTracksState(
      tracks:
          List<Track>.from(map['tracks']?.map((x) => Track.fromMap(x)) ?? []),
      albumTracks: List<Track>.from(
          map['albumTracks']?.map((x) => Track.fromMap(x)) ?? []),
      topTracks: List<Track>.from(
          map['topTracks']?.map((x) => Track.fromMap(x)) ?? []),
      isIntial: map['isIntial'] ?? true,
      isLoading: map['isLoading'] ?? false,
      errorMessage: map['errorMessage'] ?? '',
      isError: map['isError'] ?? false,
    );
  }
}
