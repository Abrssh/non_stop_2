import 'package:non_stop_2/Data/Model/track.dart';

abstract class GetTracksUseCase {
  Future<List<Track>> getTopTracks();
  Future<List<Track>> getTracks(String query);
  Future<List<Track>> getTracksByAlbum(String albumId);
}
