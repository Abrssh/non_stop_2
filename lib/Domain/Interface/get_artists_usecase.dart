import 'package:non_stop_2/Data/Model/artist.dart';

abstract class GetArtistsUseCase {
  Future<List<Artist>> getArtists();
}
