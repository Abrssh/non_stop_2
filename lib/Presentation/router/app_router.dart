import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop_2/Data/API/rapid_api_datasource.dart';
import 'package:non_stop_2/Data/Repository/album_repository.dart';
import 'package:non_stop_2/Data/Repository/track_repository.dart';
import 'package:non_stop_2/Domain/bloc/album_bloc/get_albums_bloc.dart';
import 'package:non_stop_2/Domain/bloc/internet_bloc/internet_conn_bloc.dart';
import 'package:non_stop_2/Domain/bloc/track_bloc/track_bloc.dart';

import 'package:non_stop_2/Domain/cubit/bottom_navigation_cubit.dart';
import 'package:non_stop_2/Presentation/Pages/home_pages.dart';
import 'package:non_stop_2/Presentation/Pages/splash_screen.dart';

class AppRouter {
  final BottomNavigationCubit _bottomNavigationCubit = BottomNavigationCubit();
  final InternetConnBloc _internetConnBloc = InternetConnBloc();

  final RepositoryProvider _trackRepositoryProvider = RepositoryProvider(
    create: (context) =>
        TrackRepository(rapidApiDatasource: RapidApiDatasource()),
    lazy: true,
  );

  final RepositoryProvider _albumRepositoryProvider = RepositoryProvider(
    create: (context) =>
        AlbumRepository(rapidApiDatasource: RapidApiDatasource()),
    lazy: true,
  );

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: _bottomNavigationCubit,
                  child: const IntroScreen(),
                ));
      case '/home':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
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
                          albumsUseCase: context.read<AlbumRepository>()),
                    )
                  ],
                  child: MultiRepositoryProvider(
                    providers: [
                      RepositoryProvider.value(value: _trackRepositoryProvider),
                      RepositoryProvider.value(value: _albumRepositoryProvider),
                    ],
                    child: const MyHomePage(),
                  ),
                ));
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
