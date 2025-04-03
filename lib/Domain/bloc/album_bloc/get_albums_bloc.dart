import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:non_stop_2/Data/Model/album.dart';
import 'package:non_stop_2/Domain/Interface/get_albums_usecase.dart';

part 'get_albums_event.dart';
part 'get_albums_state.dart';

class GetAlbumsBloc extends HydratedBloc<GetAlbumsEvent, GetAlbumsState> {
  final GetAlbumsUseCase albumsUseCase;
  GetAlbumsBloc({required this.albumsUseCase}) : super(const GetAlbumsState()) {
    debugPrint("GetAlbumsBloc constructor called");
    on<GetPopularAlbumsEvent>(_getAlbums);
    on<GetArtistAlbumsEvent>(_getArtistAlbums);
    add(const GetPopularAlbumsEvent());
  }

  void _getAlbums(
      GetPopularAlbumsEvent event, Emitter<GetAlbumsState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, isError: false, errorMessage: ""));
      List<Album> albums = await albumsUseCase.getAlbums();
      emit(state.copyWith(albumsList: albums, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString(), isError: true, isLoading: false));
    }
  }

  void _getArtistAlbums(
      GetArtistAlbumsEvent event, Emitter<GetAlbumsState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, isError: false, errorMessage: ""));
      List<Album> albums =
          await albumsUseCase.getAlbumsByArtist(event.artistId);
      emit(state.copyWith(artistAlbums: albums, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString(), isError: true, isLoading: false));
    }
  }

  @override
  GetAlbumsState? fromJson(Map<String, dynamic> json) {
    try {
      return GetAlbumsState.fromJson(json);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(GetAlbumsState state) {
    try {
      return state.toJson();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
