import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop_2/Domain/bloc/artist_bloc/artist_bloc.dart';

class CustomArtistWidget extends StatelessWidget {
  final String artistName, imageUrl;
  const CustomArtistWidget(
      {super.key, required this.artistName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 140,
            child: Card(
              elevation: 4,
              child: ClipRRect(
                // clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  // height: 170,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 40,
            child: Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                Text(
                  artistName.length > 20
                      ? '${artistName.substring(0, 17)}...'
                      : artistName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ArtistGrid extends StatelessWidget {
  const ArtistGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArtistBloc, ArtistState>(
      listener: (context, state) {
        debugPrint(
            "Number of artists: ${state.artists.length} and isLoading: ${state.isLoading} and isError: ${state.isError} and errorMessage: ${state.errorMessage}");
        if (state.isError && !state.isLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              margin: const EdgeInsets.only(
                bottom: 80, // Adjust based on your bottom nav height
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
        return !state.isLoading
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: state.artists.length,
                itemBuilder: (BuildContext context, int index) {
                  return CustomArtistWidget(
                    artistName: state.artists[index].name,
                    imageUrl: state.artists[index].largeImageUrl,
                  );
                },
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
