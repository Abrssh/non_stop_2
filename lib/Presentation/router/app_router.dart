import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop_2/Domain/bloc/internet_conn_bloc.dart';
import 'package:non_stop_2/Domain/cubit/bottom_navigation_cubit.dart';
import 'package:non_stop_2/Presentation/Pages/home_pages.dart';
import 'package:non_stop_2/Presentation/Pages/splash_screen.dart';

class AppRouter {
  final BottomNavigationCubit _bottomNavigationCubit = BottomNavigationCubit();
  final InternetConnBloc _internetConnBloc = InternetConnBloc();

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
                  ],
                  child: const MyHomePage(),
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
  }
}
