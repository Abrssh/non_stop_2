import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:non_stop_2/Domain/bloc/internet_conn_bloc.dart';
import 'package:non_stop_2/Domain/cubit/bottom_navigation_cubit.dart';
import 'package:non_stop_2/Presentation/Pages/album_page.dart';
import 'package:non_stop_2/Presentation/Pages/artist_page.dart';
import 'package:non_stop_2/Presentation/Pages/first_page.dart';
import 'package:non_stop_2/Presentation/Pages/track_page.dart';
import 'package:non_stop_2/Presentation/Widgets/custom_bottom_navigation_bar.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      const FirstPage(),
      const AlbumPage(),
      const ArtistPage(),
      Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          TrackPage(
            height: MediaQuery.of(context).size.height * 0.88,
          ),
        ],
      ),
    ];

    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(93, 63, 130, 1),
                  Color.fromRGBO(62, 41, 90, 1),
                ],
              ),
            ),
          ),
          // Animated Background Color Change
          // BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
          //   builder: (context, state) {
          //     List<List<Color>> gradients = [
          //       [
          //         const Color.fromRGBO(93, 63, 130, 1),
          //         const Color.fromRGBO(62, 41, 90, 1),
          //       ],
          //       [
          //         const Color.fromRGBO(143, 63, 130, 1),
          //         const Color.fromRGBO(112, 41, 90, 1),
          //       ],
          //       [
          //         const Color.fromRGBO(63, 143, 130, 1),
          //         const Color.fromRGBO(41, 112, 90, 1),
          //       ],
          //       [
          //         const Color.fromRGBO(63, 63, 143, 1),
          //         const Color.fromRGBO(41, 41, 112, 1),
          //       ],
          //     ];

          //     return AnimatedContainer(
          //       duration:
          //           const Duration(milliseconds: 700), // Animation duration
          //       curve: Curves.easeIn, // Animation curve
          //       width: double.infinity,
          //       height: double.infinity,
          //       decoration: BoxDecoration(
          //         gradient: LinearGradient(
          //           begin: Alignment.topLeft,
          //           end: Alignment.bottomRight,
          //           colors: gradients[state.currentIndex],
          //         ),
          //       ),
          //     );
          //   },
          // ),
          BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
            builder: (context, state) {
              return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: tabs[state.currentIndex]);
            },
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavBar(),
          ),
        ],
      ),
    );
  }
}
