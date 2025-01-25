abstract class GetAlbumsUseCase<Album> {
  Future<List<Album>> getAlbums();
  Future<List<Album>> getAlbumsByArtist(String artistId);
}
