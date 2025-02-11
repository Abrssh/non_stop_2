import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop_2/Domain/bloc/track_bloc/track_bloc.dart';
import 'package:non_stop_2/Presentation/Widgets/custom_track_list.dart';

class AlbumTracksPage extends StatelessWidget {
  final String name;
  final String largeImageUrl;
  final String smallImageUrl;
  final String artist;
  final String releaseDate;

  const AlbumTracksPage({
    required this.name,
    required this.largeImageUrl,
    required this.smallImageUrl,
    required this.artist,
    required this.releaseDate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () => Navigator.of(context).pop(),
            ),
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                name,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 15),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    largeImageUrl,
                    fit: BoxFit.cover,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withAlpha(195)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      artist,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.grey.shade300),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Released: $releaseDate',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey.shade300),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withAlpha(200)),
              child: BlocConsumer<TrackBloc, TrackState>(
                listener: (context, state) {
                  debugPrint(
                      "AlbumTracks Page Error: ${state.errorMessage} isLoading: ${state.isLoading} isError: ${state.isError}");
                  if (state.isError && !state.isLoading) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
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
                  return state.isLoading
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child:
                              const Center(child: CircularProgressIndicator()),
                        )
                      : CustomTrackList(
                          height: MediaQuery.of(context).size.height * 0.6,
                          tracks: state.albumTracks,
                          imageUrl: smallImageUrl,
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
