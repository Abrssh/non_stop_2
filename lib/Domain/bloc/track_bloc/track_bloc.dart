import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:non_stop_2/Data/Model/track.dart';
import 'package:non_stop_2/Domain/Interface/get_tracks_usecase.dart';

part 'track_event.dart';
part 'track_state.dart';

class TrackBloc extends HydratedBloc<TrackEvent, TrackState> {
  final GetTracksUseCase getTracksUseCase;

  TrackBloc({required this.getTracksUseCase})
      : super(const SearchedTracksState()) {
    on<SearchTracksEvent>(_onSearchTracks);
    on<GetTopTracksEvent>(_onGetTopTracks);
    on<GetTracksByAlbumEvent>(_onGetTracksByAlbum);
    add(const GetTopTracksEvent());
  }

  Future<void> _onGetTracksByAlbum(
      GetTracksByAlbumEvent event, Emitter<TrackState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, isError: false));
      List<Track> tracks =
          await getTracksUseCase.getTracksByAlbum(event.albumId);
      emit(state.copyWith(albumTracks: tracks, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString(), isError: true, isLoading: false));
      debugPrint("Error getting tracks by album. ${state.isError}");
    }
  }

  Future<void> _onSearchTracks(
      SearchTracksEvent event, Emitter<TrackState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, isError: false));
      List<Track> tracks = await getTracksUseCase.getTracks(event.query);
      emit(state.copyWith(tracks: tracks, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString(), isError: true, isLoading: false));
    }
  }

  Future<void> _onGetTopTracks(
      GetTopTracksEvent event, Emitter<TrackState> emit) async {
    try {
      debugPrint("Getting top tracks");
      emit(state.copyWith(isLoading: true, isError: false, isIntial: true));
      List<Track> tracks = await getTracksUseCase.getTopTracks();
      emit(state.copyWith(
          tracks: tracks,
          topTracks: tracks,
          isLoading: false,
          isIntial: true,
          errorMessage: ''));
      emit(state.copyWith(isIntial: false));
      // emit(state.copyWith(
      //     isIntial: false, errorMessage: Random().nextInt(100).toString()));
    } catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString(), isError: true, isLoading: false));
    }
  }

  @override
  SearchedTracksState? fromJson(Map<String, dynamic> json) {
    try {
      debugPrint("Retrieving state from JSON: ${json["errorMessage"]}");
      return SearchedTracksState.fromJson(json);
    } catch (e) {
      debugPrint('Error deserializing state: $e');
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(TrackState state) {
    try {
      debugPrint(
          'Saving state: ${state.isIntial} Test Message: ${state.errorMessage}');
      if (state is SearchedTracksState) {
        return state.toJson();
      }
      return null;
    } catch (e) {
      debugPrint('Error serializing state: $e');
      return null;
    }
  }
}
