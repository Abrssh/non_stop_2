import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop_2/Data/API/rapid_api_datasource.dart';
import 'package:non_stop_2/Data/Repository/album_repository.dart';
import 'package:non_stop_2/Data/Repository/artist_repository.dart';
import 'package:non_stop_2/Data/Repository/track_repository.dart';
import 'package:non_stop_2/Domain/bloc/album_bloc/get_albums_bloc.dart';
import 'package:non_stop_2/Domain/bloc/artist_bloc/artist_bloc.dart';
import 'package:non_stop_2/Domain/bloc/internet_bloc/internet_conn_bloc.dart';
import 'package:non_stop_2/Domain/bloc/track_bloc/track_bloc.dart';

import 'package:non_stop_2/Domain/cubit/bottom_navigation_cubit.dart';
import 'package:non_stop_2/Presentation/Pages/home_pages.dart';
import 'package:non_stop_2/Presentation/Pages/splash_screen.dart';

class AppRouter {
  final BottomNavigationCubit _bottomNavigationCubit = BottomNavigationCubit();
  final InternetConnBloc _internetConnBloc = InternetConnBloc();

  final AlbumRepository _albumRepository = AlbumRepository(
    rapidApiDatasource: RapidApiDatasource(),
  );

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
              RepositoryProvider(
                create: (context) =>
                    TrackRepository(rapidApiDatasource: RapidApiDatasource()),
                lazy: true,
              ),
              RepositoryProvider.value(value: _albumRepository),
              RepositoryProvider(
                create: (context) =>
                    ArtistRepository(rapidApiDatasource: RapidApiDatasource()),
                lazy: true,
              ),
            ],
            child: Builder(builder: (context) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: _bottomNavigationCubit),
                  BlocProvider.value(value: _internetConnBloc),
                  BlocProvider(
                    lazy: true,
                    create: (context) => TrackBloc(
                      getTracksUseCase: context.read<TrackRepository>(),
                    ),
                  ),
                  BlocProvider(
                    lazy: true,
                    create: (context) => GetAlbumsBloc(
                      albumsUseCase: context.read<AlbumRepository>(),
                    ),
                  ),
                  BlocProvider(
                    lazy: true,
                    create: (context) => ArtistBloc(
                        getArtistsUseCase: context.read<ArtistRepository>()),
                  ),
                ],
                child: const MyHomePage(),
              );
            }),
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
