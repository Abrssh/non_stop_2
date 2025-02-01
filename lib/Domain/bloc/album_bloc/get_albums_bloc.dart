import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop_2/Data/Model/album.dart';
import 'package:non_stop_2/Domain/Interface/get_albums_usecase.dart';

part 'get_albums_event.dart';
part 'get_albums_state.dart';

class GetAlbumsBloc extends Bloc<GetAlbumsEvent, GetAlbumsState> {
  final GetAlbumsUseCase albumsUseCase;
  GetAlbumsBloc({required this.albumsUseCase}) : super(const GetAlbumsState()) {
    debugPrint("GetAlbumsBloc constructor called");
    on<GetPopularAlbumsEvent>(_getAlbums);
    on<GetArtistAlbumsEvent>(_getArtistAlbums);
    add(const GetPopularAlbumsEvent());
  }

  void _getAlbums(
      GetPopularAlbumsEvent event, Emitter<GetAlbumsState> emit) async {
    emit(const GetAlbumsState(isLoading: true));
    try {
      emit(const GetAlbumsState(isLoading: true, isError: false));
      List<Album> albums = await albumsUseCase.getAlbums();
      emit(state.copyWith(albumsList: albums, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString(), isError: true, isLoading: false));
    }
  }

  void _getArtistAlbums(
      GetArtistAlbumsEvent event, Emitter<GetAlbumsState> emit) async {
    emit(const GetAlbumsState(isLoading: true, isError: false));
    try {
      emit(const GetAlbumsState(isLoading: true, isError: false));
      List<Album> albums =
          await albumsUseCase.getAlbumsByArtist(event.artistId);
      emit(state.copyWith(albumsList: albums, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString(), isError: true, isLoading: false));
    }
  }
}
