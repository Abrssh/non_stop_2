import 'package:non_stop_2/Data/API/rapid_api_datasource.dart';
import 'package:non_stop_2/Data/Model/album.dart';
import 'package:non_stop_2/Domain/Interface/get_albums_usecase.dart';

class AlbumRepository implements GetAlbumsUseCase {
  final RapidApiDatasource rapidApiDatasource;

  AlbumRepository({required this.rapidApiDatasource});

  @override
  Future<List<Album>> getAlbums() async {
    try {
      List<dynamic> fetchedAlbums = await rapidApiDatasource.fetchGroupData();
      return fetchedAlbums.map((album) {
        Album albumData = Album.fromJson(album);
        return albumData;
      }).toList();
    } catch (e) {
      throw Exception(
          "An Error occurred while processing album data. Error Info: $e");
    }
  }

  @override
  Future<List<Album>> getAlbumsByArtist(String artistId) async {
    try {
      List<dynamic> fetchedAlbums =
          await rapidApiDatasource.fetchArtistAlbums(artistId);
      return fetchedAlbums.map((album) {
        Album albumData = Album.fromJson(album);
        return albumData;
      }).toList();
    } catch (e) {
      throw Exception(
          "An Error occurred while processing album data. Error Info: $e");
    }
  }
}
