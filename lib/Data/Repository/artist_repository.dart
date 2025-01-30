import 'package:non_stop_2/Data/API/rapid_api_datasource.dart';
import 'package:non_stop_2/Data/Model/artist.dart';
import 'package:non_stop_2/Domain/Interface/get_artists_usecase.dart';

class ArtistRepository implements GetArtistsUseCase {
  final RapidApiDatasource rapidApiDatasource;

  ArtistRepository({required this.rapidApiDatasource});

  @override
  Future<List<Artist>> getArtists() async {
    try {
      List<dynamic> fetchedArtists =
          await rapidApiDatasource.fetchGroupData(type: "artists");
      return fetchedArtists.map((artist) {
        Artist artistData = Artist.fromJson(artist);
        return artistData;
      }).toList();
    } catch (e) {
      throw Exception(
          "An Error occurred while processing artist data. Error Info: $e");
    }
  }
}
