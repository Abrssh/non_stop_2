part of 'get_albums_bloc.dart';

sealed class GetAlbumsEvent extends Equatable {
  const GetAlbumsEvent();

  @override
  List<Object> get props => [];
}

class GetPopularAlbumsEvent extends GetAlbumsEvent {
  const GetPopularAlbumsEvent();
}

class GetArtistAlbumsEvent extends GetAlbumsEvent {
  final String artistId;
  const GetArtistAlbumsEvent({required this.artistId});
}
