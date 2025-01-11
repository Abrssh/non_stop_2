import 'package:flutter/material.dart';
import 'package:non_stop_2/Widgets/custom_bottom_navigation_bar.dart';
import 'package:non_stop_2/Widgets/custom_genre_selector.dart';
import 'package:non_stop_2/Widgets/custom_track_card.dart';
import 'package:non_stop_2/Widgets/music_card.dart';
import 'package:non_stop_2/Widgets/search_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final List<CustomTrackCard> trackCards = const [
    CustomTrackCard(
        width: 100,
        height: 80,
        isFavorite: true,
        trackName: "Blinding Lights",
        artistName: "The Weeknd"),
    CustomTrackCard(
        width: 100,
        height: 80,
        isFavorite: false,
        trackName: "Stay With Me",
        artistName: "Sam Smith"),
    CustomTrackCard(
        width: 100,
        height: 80,
        isFavorite: true,
        trackName: "Bad Guy",
        artistName: "Billie Eilish"),
    CustomTrackCard(
        width: 100,
        height: 80,
        isFavorite: true,
        trackName: "Shape of You",
        artistName: "Ed Sheeran"),
    CustomTrackCard(
        width: 100,
        height: 80,
        isFavorite: false,
        trackName: "Uptown Funk",
        artistName: "Mark Ronson"),
    CustomTrackCard(
        width: 100,
        height: 80,
        isFavorite: true,
        trackName: "Rolling in the Deep",
        artistName: "Adele"),
    CustomTrackCard(
        width: 100,
        height: 80,
        isFavorite: false,
        trackName: "Despacito",
        artistName: "Luis Fonsi"),
    CustomTrackCard(
        width: 100,
        height: 80,
        isFavorite: true,
        trackName: "Havana",
        artistName: "Camila Cabello"),
    CustomTrackCard(
        width: 100,
        height: 80,
        isFavorite: false,
        trackName: "Someone Like You",
        artistName: "Adele"),
    CustomTrackCard(
        width: 100,
        height: 80,
        isFavorite: true,
        trackName: "Happy",
        artistName: "Pharrell Williams"),
    CustomTrackCard(
        width: 100,
        height: 80,
        isFavorite: false,
        trackName: "Royals",
        artistName: "Lorde"),
    CustomTrackCard(
        width: 100,
        height: 80,
        isFavorite: true,
        trackName: "Shake It Off",
        artistName: "Taylor Swift"),
    CustomTrackCard(
        width: 100,
        height: 80,
        isFavorite: false,
        trackName: "Get Lucky",
        artistName: "Daft Punk"),
    CustomTrackCard(
        width: 100,
        height: 80,
        isFavorite: true,
        trackName: "All About That Bass",
        artistName: "Meghan Trainor"),
    CustomTrackCard(
        width: 100,
        height: 80,
        isFavorite: false,
        trackName: "Can't Stop the Feeling",
        artistName: "Justin Timberlake"),
  ];

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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
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
                          "Trending right now",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 160,
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
                    const CustomGenreSelector(),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 230,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => trackCards[index],
                          itemCount: trackCards.length,
                        ))
                  ],
                ),
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
