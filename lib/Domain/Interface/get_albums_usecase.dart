import 'package:non_stop_2/Data/Model/album.dart';

abstract class GetAlbumsUseCase {
  Future<List<Album>> getAlbums();
  Future<List<Album>> getAlbumsByArtist(String artistId);
}
