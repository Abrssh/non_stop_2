import 'dart:convert';
import 'package:non_stop_2/Data/Model/track.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageDataSource {
  final SharedPreferences prefs;

  LocalStorageDataSource({required this.prefs});

  Future<List<Track>?> getTopTracksFromCache() async {
    final String? cachedData = prefs.getString('top_tracks');
    if (cachedData != null) {
      final List<dynamic> decodedData = json.decode(cachedData);
      return decodedData.map((track) => Track.fromMap(track)).toList();
    }
    return null;
  }

  Future<void> cacheTopTracks(List<Track> tracks) async {
    final List<Map<String, dynamic>> trackMaps =
        tracks.map((track) => track.toMap()).toList();
    await prefs.setString('top_tracks', json.encode(trackMaps));
  }

  Future<List<Track>?> getTracksFromCache(String query) async {
    final String? cachedData = prefs.getString('tracks_$query');
    if (cachedData != null) {
      final List<dynamic> decodedData = json.decode(cachedData);
      return decodedData.map((track) => Track.fromMap(track)).toList();
    }
    return null;
  }

  Future<void> cacheTracks(String query, List<Track> tracks) async {
    final List<Map<String, dynamic>> trackMaps =
        tracks.map((track) => track.toMap()).toList();
    await prefs.setString('tracks_$query', json.encode(trackMaps));
  }

  Future<List<Track>?> getAlbumTracksFromCache(String albumId) async {
    final String? cachedData = prefs.getString('album_tracks_$albumId');
    if (cachedData != null) {
      final List<dynamic> decodedData = json.decode(cachedData);
      return decodedData.map((track) => Track.fromMap(track)).toList();
    }
    return null;
  }

  Future<void> cacheAlbumTracks(String albumId, List<Track> tracks) async {
    final List<Map<String, dynamic>> trackMaps =
        tracks.map((track) => track.toMap()).toList();
    await prefs.setString('album_tracks_$albumId', json.encode(trackMaps));
  }

  Future<void> clearCache() async {
    await prefs.clear();
  }
}
