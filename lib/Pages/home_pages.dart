import 'package:flutter/material.dart';
import 'package:non_stop_2/Widgets/custom_bottom_navigation_bar.dart';
import 'package:non_stop_2/Widgets/custom_genre_selector.dart';
import 'package:non_stop_2/Widgets/music_card.dart';
import 'package:non_stop_2/Widgets/search_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const SearchWidget(),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Trending Right Now",
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 175,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: (_, index) {
                        return const MusicCard();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomGenreSelector()
                ],
              ),
            ),
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: CustomBottomNavBar(),
        ),
        // FractionallySizedBox(
        //   // height: 400,
        //   // width: 200,
        //   widthFactor: 0.8,
        //   heightFactor: 0.9,
        //   child: ListView.builder(
        //     scrollDirection: Axis.vertical,
        //     itemCount: 8,
        //     itemBuilder: (_, index) {
        //       return const SizedBox(
        //         height: 200,
        //         child: Padding(
        //           padding: EdgeInsets.all(8.0),
        //           child: MusicCard(),
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
