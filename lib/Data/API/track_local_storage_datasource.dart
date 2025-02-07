import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:non_stop_2/Data/Model/track.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackLocalStorageDataSource {
  final SharedPreferences prefs;

  TrackLocalStorageDataSource({required this.prefs});

  Future<List<Track>> getTopTracksFromCache() async {
    try {
      final String? cachedData = prefs.getString('top_tracks');
      if (cachedData != null) {
        final List<dynamic> decodedData = json.decode(cachedData);
        return decodedData.map((track) => Track.fromMap(track)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to get top tracks from cache: $e');
    }
  }

  Future<void> cacheTopTracks(List<Track> tracks) async {
    try {
      final List<Map<String, dynamic>> trackMaps =
          tracks.map((track) => track.toMap()).toList();
      await prefs.setString('top_tracks', json.encode(trackMaps));
      debugPrint('Successfully cached ${tracks.length} top tracks');
    } catch (e) {
      throw Exception('Failed to cache top tracks: $e');
    }
  }

  Future<List<Track>> getTracksFromCache(String query) async {
    try {
      final String? cachedData = prefs.getString('tracks_$query');
      if (cachedData != null) {
        final List<dynamic> decodedData = json.decode(cachedData);
        return decodedData.map((track) => Track.fromMap(track)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to get tracks from cache: $e');
    }
  }

  Future<void> cacheTracks(String query, List<Track> tracks) async {
    try {
      final List<Map<String, dynamic>> trackMaps =
          tracks.map((track) => track.toMap()).toList();
      await prefs.setString('tracks_$query', json.encode(trackMaps));
      debugPrint('Successfully cached ${tracks.length} tracks');
    } catch (e) {
      throw Exception('Failed to cache tracks: $e');
    }
  }

  Future<List<Track>> getAlbumTracksFromCache(String albumId) async {
    try {
      final String? cachedData = prefs.getString('album_tracks_$albumId');
      if (cachedData != null) {
        final List<dynamic> decodedData = json.decode(cachedData);
        return decodedData.map((track) => Track.fromMap(track)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to get album tracks from cache: $e');
    }
  }

  Future<void> cacheAlbumTracks(String albumId, List<Track> tracks) async {
    try {
      final List<Map<String, dynamic>> trackMaps =
          tracks.map((track) => track.toMap()).toList();
      await prefs.setString('album_tracks_$albumId', json.encode(trackMaps));
      debugPrint('Successfully cached ${tracks.length} album tracks');
    } catch (e) {
      throw Exception('Failed to cache album tracks: $e');
    }
  }

  Future<void> clearTrackCache() async {
    try {
      final keys = prefs.getKeys();
      // debugPrint('keys: $keys');
      for (final key in keys) {
        if (key.startsWith('top_tracks') ||
            key.startsWith('tracks_') ||
            key.startsWith('album_tracks_')) {
          await prefs.remove(key);
        }
      }
      // debugPrint("Pref data ${prefs.getString('top_tracks')}");
    } catch (e) {
      throw Exception('Failed to clear track cache: $e');
    }
  }

  Future<void> clearAllCache() async {
    try {
      await prefs.clear();
    } catch (e) {
      throw Exception('Failed to clear all cache: $e');
    }
  }
}
