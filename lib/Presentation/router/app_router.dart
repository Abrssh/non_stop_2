import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop_2/Data/API/album_local_storage_datasource.dart';
import 'package:non_stop_2/Data/API/artist_local_storage_datasource.dart';
import 'package:non_stop_2/Data/API/track_local_storage_datasource.dart';
import 'package:non_stop_2/Data/API/rapid_api_datasource.dart';
import 'package:non_stop_2/Data/Repository/album_repository.dart';
import 'package:non_stop_2/Data/Repository/artist_repository.dart';
import 'package:non_stop_2/Data/Repository/track_repository.dart';
import 'package:non_stop_2/Dependency%20Injection/service_locator.dart';
import 'package:non_stop_2/Domain/bloc/album_bloc/get_albums_bloc.dart';
import 'package:non_stop_2/Domain/bloc/artist_bloc/artist_bloc.dart';
import 'package:non_stop_2/Domain/bloc/internet_bloc/internet_conn_bloc.dart';
import 'package:non_stop_2/Domain/bloc/track_bloc/track_bloc.dart';

import 'package:non_stop_2/Domain/cubit/bottom_navigation_cubit.dart';
import 'package:non_stop_2/Presentation/Pages/album_tracks_page.dart';
import 'package:non_stop_2/Presentation/Pages/artist_albums_page.dart';
import 'package:non_stop_2/Presentation/Pages/home_pages.dart';
import 'package:non_stop_2/Presentation/Pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRouter {
  final BottomNavigationCubit _bottomNavigationCubit = BottomNavigationCubit();
  final InternetConnBloc _internetConnBloc = InternetConnBloc();
  final SharedPreferences sharedPreferences;

  AppRouter({required this.sharedPreferences}) {
    setupServiceLocator(sharedPreferences);
  }

  Route onGenerateRoute(RouteSettings settings) {
    debugPrint("Called onGenerateRoute");
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: _bottomNavigationCubit,
                  child: const IntroScreen(),
                ));
      case '/home':
        return MaterialPageRoute(
          builder: (context) => MultiRepositoryProvider(
            providers: [
              RepositoryProvider.value(value: getIt<ArtistRepository>())
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _bottomNavigationCubit),
                BlocProvider.value(value: _internetConnBloc),
                BlocProvider.value(value: getIt<TrackBloc>()),
                BlocProvider.value(value: getIt<GetAlbumsBloc>()),
                BlocProvider.value(value: getIt<ArtistBloc>()),
              ],
              child: const MyHomePage(),
            ),
          ),
        );
      case '/album-tracks':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<TrackBloc>()),
            ],
            child: AlbumTracksPage(
              name: args['name'],
              largeImageUrl: args['largeImageUrl'],
              artist: args['artist'],
              releaseDate: args['releaseDate'],
              smallImageUrl: args['smallImageUrl'],
            ),
          ),
        );
      case '/artist-albums':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<GetAlbumsBloc>()),
              BlocProvider.value(value: getIt<TrackBloc>()),
            ],
            child: ArtistAlbumsPage(
                name: args["name"], largeImageUrl: args["largeImageUrl"]),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Page not found"),
            ),
          ),
        );
    }
  }

  void dispose() {
    _bottomNavigationCubit.close();
    _internetConnBloc.close();
  }
}
