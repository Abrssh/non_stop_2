import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop_2/Domain/bloc/track_bloc/track_bloc.dart';
import 'package:non_stop_2/Presentation/Pages/track_page.dart';
import 'package:non_stop_2/Presentation/Widgets/custom_genre_selector.dart';
import 'package:non_stop_2/Presentation/Widgets/music_card.dart';
import 'package:non_stop_2/Presentation/Widgets/search_widget.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Padding(
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
                BlocConsumer<TrackBloc, TrackState>(
                  listener: (context, state) {
                    // debugPrint(
                    //     "FirstPage Listen isIntial: ${state.isIntial} and isLoading: ${state.isLoading} and tracks: ${state.tracks.length} error: ${state.errorMessage}");
                    if (state.isError && !state.isLoading) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          margin: const EdgeInsets.only(
                            bottom:
                                80, // Adjust based on your bottom nav height
                            left: 10,
                            right: 10,
                          ),
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            state.errorMessage,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    // debugPrint(
                    //     "Number of tracks: ${state.tracks.length} isIntial: ${state.isIntial} and isLoading: ${state.isLoading} error: ${state.errorMessage}");
                    return !state.isLoading
                        ? SizedBox(
                            // height: 160,
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.topTracks.length,
                              itemBuilder: (_, index) {
                                return MusicCard(
                                  imageUrl:
                                      state.topTracks[index].largeImageUrl,
                                );
                              },
                            ),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: const Center(
                                child: CircularProgressIndicator()));
                  },
                  buildWhen: (previous, current) =>
                      previous.topTracks != current.topTracks,
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomGenreSelector(),
                const SizedBox(
                  height: 10,
                ),
                const TrackPage(height: 230)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
