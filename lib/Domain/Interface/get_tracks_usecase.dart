abstract class GetTracksUseCase<Track> {
  Future<List<Track>> getTracks(String query);
  Future<List<Track>> getTracksByAlbum(String albumId);
}
