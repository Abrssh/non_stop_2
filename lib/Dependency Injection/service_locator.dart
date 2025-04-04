import 'package:get_it/get_it.dart';
import 'package:non_stop_2/Data/API/album_local_storage_datasource.dart';
import 'package:non_stop_2/Data/API/artist_local_storage_datasource.dart';
import 'package:non_stop_2/Data/API/rapid_api_datasource.dart';
import 'package:non_stop_2/Data/API/track_local_storage_datasource.dart';
import 'package:non_stop_2/Data/Repository/album_repository.dart';
import 'package:non_stop_2/Data/Repository/artist_repository.dart';
import 'package:non_stop_2/Data/Repository/track_repository.dart';
import 'package:non_stop_2/Domain/bloc/album_bloc/get_albums_bloc.dart';
import 'package:non_stop_2/Domain/bloc/artist_bloc/artist_bloc.dart';
import 'package:non_stop_2/Domain/bloc/track_bloc/track_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

void setupServiceLocator(SharedPreferences sharedPreferences) {
  // Data Sources
  getIt.registerLazySingleton(() => RapidApiDatasource());
  getIt.registerLazySingleton(
      () => TrackLocalStorageDataSource(prefs: sharedPreferences));
  getIt.registerLazySingleton(
      () => AlbumLocalStorageDatasource(prefs: sharedPreferences));
  getIt.registerLazySingleton(
      () => ArtistLocalStorageDatasource(prefs: sharedPreferences));

  // Repositories
  getIt.registerLazySingleton(() => TrackRepository(
        rapidApiDatasource: getIt<RapidApiDatasource>(),
        trackLocalStorageDataSource: getIt<TrackLocalStorageDataSource>(),
      ));

  getIt.registerLazySingleton(() => ArtistRepository(
        rapidApiDatasource: getIt<RapidApiDatasource>(),
        artistLocalStorageDatasource: getIt<ArtistLocalStorageDatasource>(),
      ));

  getIt.registerLazySingleton(() => AlbumRepository(
        rapidApiDatasource: getIt<RapidApiDatasource>(),
        albumLocalStorageDatasource: getIt<AlbumLocalStorageDatasource>(),
      ));

  // Blocs
  getIt.registerSingleton<TrackBloc>(
      TrackBloc(getTracksUseCase: getIt<TrackRepository>()));
  getIt.registerLazySingleton(
      () => ArtistBloc(getArtistsUseCase: getIt<ArtistRepository>()));
  getIt.registerLazySingleton(
      () => GetAlbumsBloc(albumsUseCase: getIt<AlbumRepository>()));
}
