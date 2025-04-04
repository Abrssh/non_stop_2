import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:non_stop_2/Data/Model/artist.dart';
import 'package:non_stop_2/Domain/Interface/get_artists_usecase.dart';

part 'artist_event.dart';
part 'artist_state.dart';

class ArtistBloc extends HydratedBloc<GetArtistsEvent, ArtistState> {
  final GetArtistsUseCase getArtistsUseCase;
  ArtistBloc({required this.getArtistsUseCase}) : super(const ArtistState()) {
    debugPrint("ArtistBloc constructor called");
    on<GetArtistsEvent>(_onGetArtists);
    add(const GetArtistsEvent());
  }

  Future<void> _onGetArtists(
      GetArtistsEvent event, Emitter<ArtistState> emit) async {
    try {
      debugPrint("GetArtistsEvent Executed");
      if (state.isIntial) {
        emit(state.copyWith(
            isLoading: true,
            isIntial: false,
            isError: false,
            errorMessage: ""));
      } else {
        emit(state.copyWith(isLoading: true, isError: false, errorMessage: ""));
      }
      List<Artist> artists = await getArtistsUseCase.getArtists();
      emit(state.copyWith(isLoading: false, artists: artists));
    } catch (e) {
      debugPrint("_OnGetArtists Error: $e");
      emit(state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString()));
    }
  }

  @override
  ArtistState? fromJson(Map<String, dynamic> json) {
    try {
      return ArtistState.fromJson(json);
    } catch (e) {
      debugPrint("Error in Artist fromJson: $e");
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(ArtistState state) {
    try {
      return state.toJson();
    } catch (e) {
      debugPrint("Error in Artist toJson: $e");
      return null;
    }
  }
}
