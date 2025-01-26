import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop_2/Data/Model/artist.dart';
import 'package:non_stop_2/Domain/Interface/get_artists_usecase.dart';

part 'artist_event.dart';
part 'artist_state.dart';

class ArtistBloc extends Bloc<GetArtistsEvent, ArtistState> {
  final GetArtistsUseCase getArtistsUseCase;
  ArtistBloc({required this.getArtistsUseCase}) : super(const ArtistState()) {
    on<GetArtistsEvent>(_onGetArtists);
  }

  Future<void> _onGetArtists(
      GetArtistsEvent event, Emitter<ArtistState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      List<Artist> artists = await getArtistsUseCase.getArtists();
      emit(state.copyWith(isLoading: false, artists: artists));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString()));
    }
  }
}
