part of 'track_bloc.dart';

sealed class TrackEvent extends Equatable {
  const TrackEvent();

  @override
  List<Object> get props => [];
}

class GetTopTracksEvent extends TrackEvent {
  const GetTopTracksEvent();
}

class SearchTracksEvent extends TrackEvent {
  final String query;
  const SearchTracksEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class GetTracksByAlbumEvent extends TrackEvent {
  final String albumId;
  const GetTracksByAlbumEvent({required this.albumId});

  @override
  List<Object> get props => [albumId];
}
