import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:non_stop_2/Data/Model/track.dart';
import 'package:non_stop_2/Domain/Interface/get_tracks_usecase.dart';

part 'track_event.dart';
part 'track_state.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  final GetTracksUseCase getTracksUseCase;

  TrackBloc(this.getTracksUseCase) : super(const SearchedTracksState()) {
    on<SearchTracksEvent>(_onSearchTracks);
    on<GetTopTracksEvent>(_onGetTopTracks);
    on<GetTracksByAlbumEvent>(_onGetTracksByAlbum);
  }

  Future<void> _onGetTracksByAlbum(
      GetTracksByAlbumEvent event, Emitter<TrackState> emit) async {
    try {
      emit(const AlbumTracksState(isLoading: true));
      List<Track> tracks =
          await getTracksUseCase.getTracksByAlbum(event.albumId);
      emit(AlbumTracksState(tracks: tracks));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onSearchTracks(
      SearchTracksEvent event, Emitter<TrackState> emit) async {
    try {
      emit(const SearchedTracksState(isLoading: true));
      List<Track> tracks = await getTracksUseCase.getTracks(event.query);
      emit(SearchedTracksState(tracks: tracks));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onGetTopTracks(
      GetTopTracksEvent event, Emitter<TrackState> emit) async {
    try {
      emit(const SearchedTracksState(isLoading: true));
      List<Track> tracks = await getTracksUseCase.getTopTracks();
      emit(SearchedTracksState(tracks: tracks));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
