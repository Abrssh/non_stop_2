// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_albums_bloc.dart';

sealed class GetAlbumsEvent extends Equatable {
  const GetAlbumsEvent();

  @override
  List<Object> get props => [];
}

class GetPopularAlbumsEvent extends GetAlbumsEvent {
  const GetPopularAlbumsEvent();

  @override
  String toString() => 'GetPopularAlbumsEvent()';
}

class GetArtistAlbumsEvent extends GetAlbumsEvent {
  final String artistId;
  const GetArtistAlbumsEvent({required this.artistId});

  @override
  String toString() => 'GetArtistAlbumsEvent(artistId: $artistId)';
}
