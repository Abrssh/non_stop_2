import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:non_stop_2/Domain/bloc/internet_conn_bloc.dart';
import 'package:non_stop_2/Domain/cubit/bottom_navigation_cubit.dart';
import 'package:non_stop_2/Presentation/Pages/AI/flexible_widgets.dart';
import 'package:non_stop_2/Presentation/Widgets/custom_album_widget.dart';
import 'package:non_stop_2/Presentation/Widgets/custom_bottom_navigation_bar.dart';
import 'package:non_stop_2/Presentation/Widgets/custom_genre_selector.dart';
import 'package:non_stop_2/Presentation/Widgets/custom_track_card.dart';
import 'package:non_stop_2/Presentation/Widgets/music_card.dart';
import 'package:non_stop_2/Presentation/Widgets/search_widget.dart';

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
    final List<Widget> tabs = [
      Padding(
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
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
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
                  ),
                ),

                // SizedBox(
                //   height: 200,
                //   width: 200,
                //   child: GridView.extent(
                //     // physics: const NeverScrollableScrollPhysics(),
                //     maxCrossAxisExtent: 100,
                //     children: List.generate(30, (index) {
                //       return Card(
                //         color: Colors.brown[400],
                //         child: Center(
                //           child: Text("Item $index"),
                //         ),
                //       );
                //     }),
                //   ),
                // ),
                // const SizedBox(height: 10),
                // AlbumGrid2()
              ],
            ),
          ),
        ),
      ),
      Align(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Flexible(
                flex: 10,
                child: Container(
                    color: Colors.white.withOpacity(0.05), child: AlbumGrid()),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
      Align(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Flexible(
                flex: 10,
                child: Container(
                    color: Colors.white.withOpacity(0.05), child: AlbumGrid()),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
      const FlexExamplePage(),
    ];

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
        // Internet Connection Listener
        // FractionallySizedBox(
        //   widthFactor: 0.8,
        //   heightFactor: 0.9,
        //   child: BlocListener<InternetConnBloc, InternetConnState>(
        //       listener: (context, state) {
        //         debugPrint("InternetConnState: ${state.connType}");
        //       },
        //       child: Row(
        //         children: [
        //           const Spacer(),
        //           Text(
        //             "Internet Conn",
        //             style: Theme.of(context)
        //                 .textTheme
        //                 .bodyMedium!
        //                 .copyWith(color: Colors.white),
        //           ),
        //           const Spacer(),
        //           IconButton(
        //               onPressed: () {
        //                 // context.read<InternetConnBloc>().add(
        //                 //       const CheckInternetConnEvent(param: "BlocParam"),
        //                 //     );
        //                 // context
        //                 //     .read<InternetConnBloc>()
        //                 //     .startListeningToConnectivity();
        //                 context.read<InternetConnBloc>().add(
        //                       const StartListeningEvent(param: "BlocParam"),
        //                     );
        //               },
        //               icon: const Icon(
        //                 Icons.refresh,
        //                 color: Colors.white,
        //               ))
        //         ],
        //       )),
        // )
      ],
    );
  }
}
