import 'package:flutter/material.dart';
import 'package:non_stop_2/Data/API/track_local_storage_datasource.dart';
import 'package:non_stop_2/Data/API/rapid_api_datasource.dart';
import 'package:non_stop_2/Data/Model/track.dart';
import 'package:non_stop_2/Domain/Interface/get_tracks_usecase.dart';

class TrackRepository implements GetTracksUseCase {
  final RapidApiDatasource rapidApiDatasource;
  final TrackLocalStorageDataSource trackLocalStorageDataSource;

  TrackRepository(
      {required this.rapidApiDatasource,
      required this.trackLocalStorageDataSource});

  @override
  Future<List<Track>> getTopTracks() async {
    try {
      // await trackLocalStorageDataSource.clearTrackCache();
      // First Check if the data is cached
      List<Track> cachedTracks =
          await trackLocalStorageDataSource.getTopTracksFromCache();
      if (cachedTracks.isNotEmpty) {
        debugPrint("Tracks found in cache");
        return cachedTracks;
      }
      List<dynamic> fetchedTracks =
          await rapidApiDatasource.fetchGroupData(type: "tracks");
      List<Track> tracks = fetchedTracks.map((track) {
        Track trackData = Track.fromJson(track);
        return trackData;
      }).toList();
      await trackLocalStorageDataSource.cacheTopTracks(tracks);
      return tracks;
    } catch (e) {
      throw Exception(
          "An error occurred while getting top tracks. Error info: $e");
    }
  }

  @override
  Future<List<Track>> getTracks(String query) async {
    try {
      // Doesnt Cache Tracks returned for Search as it may increase the size of the cache more than necessary
      debugPrint("Fetching tracks for query: $query");
      List<String> customGenreQueries = [
        "Best Ethiopian Songs",
        "Best Rock Songs",
        "Best Rap Songs",
        "Best Jazz Songs",
        "Best Electronic Songs",
        "Best Country Songs",
      ];
      if (customGenreQueries.contains(query)) {
        List<Track> cachedTracks =
            await trackLocalStorageDataSource.getTracksFromCache(query);
        // debugPrint("Cached Tracks: ${cachedTracks.length}");
        if (cachedTracks.isNotEmpty) {
          debugPrint("Tracks found in cache");
          return cachedTracks;
        }
      }
      List<dynamic> fetchedTracks =
          await rapidApiDatasource.fetchGroupData(query: query, type: "tracks");
      List<Track> tracks = fetchedTracks.map((track) {
        Track trackData = Track.fromJson(track);
        return trackData;
      }).toList();
      if (customGenreQueries.contains(query)) {
        await trackLocalStorageDataSource.cacheTracks(query, tracks);
      }
      return tracks;
    } catch (e) {
      throw Exception("An error occurred while getting tracks. Error info: $e");
    }
  }

  @override
  Future<List<Track>> getTracksByAlbum(String albumId) async {
    try {
      List<Track> cachedTracks =
          await trackLocalStorageDataSource.getAlbumTracksFromCache(albumId);
      if (cachedTracks.isNotEmpty) {
        debugPrint("Tracks found in cache");
        return cachedTracks;
      }
      List<dynamic> fetchedTracks =
          await rapidApiDatasource.fetchAlbumTracks(albumId);
      List<Track> tracks = fetchedTracks.map((track) {
        Track trackData = Track.fromJson(track);
        return trackData;
      }).toList();
      await trackLocalStorageDataSource.cacheTracks(albumId, tracks);
      return tracks;
    } catch (e) {
      throw Exception(
          "An error occurred while getting tracks by album. Error info: $e");
    }
  }
}
