import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:non_stop_2/Data/Model/artist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArtistLocalStorageDatasource {
  final SharedPreferences prefs;

  ArtistLocalStorageDatasource({required this.prefs});

  Future<List<Artist>> getArtistsFromCache() async {
    try {
      final String? cachedData = prefs.getString('artists');
      if (cachedData != null) {
        final List<dynamic> decodedData = json.decode(cachedData);
        return decodedData.map((artist) => Artist.fromMap(artist)).toList();
      }
      debugPrint('No artists found in cache');
      return [];
    } catch (e) {
      debugPrint('Failed to get artists from cache: $e');
      throw Exception('Failed to get artists from cache: $e');
    }
  }

  Future<void> cacheArtists(List<Artist> artists) async {
    try {
      final List<Map<String, dynamic>> artistMaps =
          artists.map((artist) => artist.toMap()).toList();
      await prefs.setString('artists', json.encode(artistMaps));
      debugPrint('Successfully cached ${artists.length} artists');
    } catch (e) {
      debugPrint('Failed to cache artists: $e');
      throw Exception('Failed to cache artists: $e');
    }
  }

  Future<void> clearArtistCache() async {
    try {
      final keys = prefs.getKeys();
      for (final key in keys) {
        if (key.startsWith('artists')) {
          await prefs.remove(key);
        }
      }
      debugPrint('Successfully cleared artist cache');
    } catch (e) {
      debugPrint('Failed to clear artist cache: $e');
      throw Exception('Failed to clear artist cache: $e');
    }
  }

  Future<void> clearAllCache() async {
    try {
      await prefs.clear();
      debugPrint('Successfully cleared all cache');
    } catch (e) {
      debugPrint('Failed to clear all cache: $e');
      throw Exception('Failed to clear all cache: $e');
    }
  }
}
