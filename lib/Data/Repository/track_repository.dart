import 'package:non_stop_2/Data/API/local_storage_datasource.dart';
import 'package:non_stop_2/Data/API/rapid_api_datasource.dart';
import 'package:non_stop_2/Data/Model/track.dart';
import 'package:non_stop_2/Domain/Interface/get_tracks_usecase.dart';

class TrackRepository implements GetTracksUseCase {
  final RapidApiDatasource rapidApiDatasource;
  final LocalStorageDataSource localStorageDataSource;

  TrackRepository(
      {required this.rapidApiDatasource, required this.localStorageDataSource});

  @override
  Future<List<Track>> getTopTracks() async {
    try {
      List<dynamic> fetchedTracks =
          await rapidApiDatasource.fetchGroupData(type: "tracks");
      return fetchedTracks.map((track) {
        Track trackData = Track.fromJson(track);
        return trackData;
      }).toList();
    } catch (e) {
      throw Exception(
          "An error occurred while getting top tracks. Error info: $e");
    }
  }

  @override
  Future<List<Track>> getTracks(String query) async {
    try {
      List<dynamic> fetchedTracks =
          await rapidApiDatasource.fetchGroupData(query: query, type: "tracks");
      return fetchedTracks.map((track) {
        Track trackData = Track.fromJson(track);
        return trackData;
      }).toList();
    } catch (e) {
      throw Exception("An error occurred while getting tracks. Error info: $e");
    }
  }

  @override
  Future<List<Track>> getTracksByAlbum(String albumId) async {
    try {
      List<dynamic> fetchedTracks =
          await rapidApiDatasource.fetchAlbumTracks(albumId);
      return fetchedTracks.map((track) {
        Track trackData = Track.fromJson(track);
        return trackData;
      }).toList();
    } catch (e) {
      throw Exception(
          "An error occurred while getting tracks by album. Error info: $e");
    }
  }
}
