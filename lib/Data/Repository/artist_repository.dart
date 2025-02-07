import 'package:flutter/material.dart';
import 'package:non_stop_2/Data/API/artist_local_storage_datasource.dart';
import 'package:non_stop_2/Data/API/rapid_api_datasource.dart';
import 'package:non_stop_2/Data/Model/artist.dart';
import 'package:non_stop_2/Domain/Interface/get_artists_usecase.dart';

class ArtistRepository implements GetArtistsUseCase {
  final RapidApiDatasource rapidApiDatasource;
  final ArtistLocalStorageDatasource artistLocalStorageDatasource;

  ArtistRepository(
      {required this.rapidApiDatasource,
      required this.artistLocalStorageDatasource}) {
    debugPrint("ArtistRepository constructor called");
  }

  @override
  Future<List<Artist>> getArtists() async {
    try {
      // First Check if the data is cached
      List<Artist> cachedArtists =
          await artistLocalStorageDatasource.getArtistsFromCache();
      if (cachedArtists.isNotEmpty) {
        debugPrint("Artists found in cache");
        return cachedArtists;
      }
      List<dynamic> fetchedArtists =
          await rapidApiDatasource.fetchGroupData(type: "artists");
      // debugPrint("Fetched Artists: $fetchedArtists");
      List<Artist> artists = fetchedArtists.map((artist) {
        Artist artistData = Artist.fromJson(artist);
        return artistData;
      }).toList();
      await artistLocalStorageDatasource.cacheArtists(artists);
      return artists;
    } catch (e) {
      throw Exception(
          "An Error occurred while processing artist data. Error Info: $e");
    }
  }
}
