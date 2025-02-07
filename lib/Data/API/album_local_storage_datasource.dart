import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:non_stop_2/Data/Model/album.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlbumLocalStorageDatasource {
  final SharedPreferences prefs;

  AlbumLocalStorageDatasource({required this.prefs});

  Future<List<Album>> getAlbumsFromCache() async {
    try {
      final String? cachedData = prefs.getString('albums');
      if (cachedData != null) {
        final List<dynamic> decodedData = json.decode(cachedData);
        return decodedData.map((album) => Album.fromMap(album)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to get albums from cache: $e');
    }
  }

  Future<void> cacheAlbums(List<Album> albums) async {
    try {
      final List<Map<String, dynamic>> albumMaps =
          albums.map((album) => album.toMap()).toList();
      await prefs.setString('albums', json.encode(albumMaps));
      debugPrint('Successfully cached ${albums.length} albums');
    } catch (e) {
      throw Exception('Failed to cache albums: $e');
    }
  }

  Future<List<Album>> getArtistAlbumsFromCache(String artistId) async {
    try {
      final String? cachedData = prefs.getString('artist_albums_$artistId');
      if (cachedData != null) {
        final List<dynamic> decodedData = json.decode(cachedData);
        return decodedData.map((album) => Album.fromMap(album)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to get artist albums from cache: $e');
    }
  }

  Future<void> cacheArtistAlbums(String artistId, List<Album> albums) async {
    try {
      final List<Map<String, dynamic>> albumMaps =
          albums.map((album) => album.toMap()).toList();
      await prefs.setString('artist_albums_$artistId', json.encode(albumMaps));
      debugPrint('Successfully cached ${albums.length} artist albums');
    } catch (e) {
      throw Exception('Failed to cache artist albums: $e');
    }
  }

  Future<void> clearAlbumCache() async {
    try {
      final keys = prefs.getKeys();
      for (final key in keys) {
        if (key.startsWith('albums') || key.startsWith('artist_albums_')) {
          await prefs.remove(key);
        }
      }
    } catch (e) {
      throw Exception('Failed to clear album cache: $e');
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
