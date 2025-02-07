import 'package:flutter/material.dart';
import 'package:non_stop_2/Data/API/album_local_storage_datasource.dart';
import 'package:non_stop_2/Data/API/rapid_api_datasource.dart';
import 'package:non_stop_2/Data/Model/album.dart';
import 'package:non_stop_2/Domain/Interface/get_albums_usecase.dart';

class AlbumRepository implements GetAlbumsUseCase {
  final RapidApiDatasource rapidApiDatasource;
  final AlbumLocalStorageDatasource albumLocalStorageDatasource;

  AlbumRepository(
      {required this.rapidApiDatasource,
      required this.albumLocalStorageDatasource}) {
    debugPrint("AlbumRepository created");
  }

  @override
  Future<List<Album>> getAlbums() async {
    try {
      // First Check if the data is cached
      List<Album> cachedAlbums =
          await albumLocalStorageDatasource.getAlbumsFromCache();
      if (cachedAlbums.isNotEmpty) {
        debugPrint("Albums found in cache");
        return cachedAlbums;
      }
      List<dynamic> fetchedAlbums = await rapidApiDatasource.fetchGroupData();
      List<Album> albums = fetchedAlbums.map((album) {
        Album albumData = Album.fromJson(album);
        return albumData;
      }).toList();
      await albumLocalStorageDatasource.cacheAlbums(albums);
      return albums;
    } catch (e) {
      debugPrint("Error occurred in getAlbums funciton: $e");
      throw Exception(
          "An Error occurred while processing album data. Error Info: $e");
    }
  }

  @override
  Future<List<Album>> getAlbumsByArtist(String artistId) async {
    try {
      // First Check if the data is cached
      List<Album> cachedAlbums =
          await albumLocalStorageDatasource.getArtistAlbumsFromCache(artistId);
      if (cachedAlbums.isNotEmpty) {
        debugPrint("Albums found in cache");
        return cachedAlbums;
      }
      List<dynamic> fetchedAlbums =
          await rapidApiDatasource.fetchArtistAlbums(artistId);
      List<Album> albums = fetchedAlbums.map((album) {
        Album albumData = Album.fromJson(album);
        return albumData;
      }).toList();
      await albumLocalStorageDatasource.cacheArtistAlbums(artistId, albums);
      return albums;
    } catch (e) {
      throw Exception(
          "An Error occurred while processing album data. Error Info: $e");
    }
  }
}
