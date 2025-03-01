import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop_2/Domain/bloc/album_bloc/get_albums_bloc.dart';
import 'package:non_stop_2/Domain/bloc/artist_bloc/artist_bloc.dart';

class CustomArtistWidget extends StatelessWidget {
  final String artistName, imageUrl;
  final String artistId;
  const CustomArtistWidget(
      {super.key,
      required this.artistName,
      required this.artistId,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // debugPrint("Artist Id: $artistId");
        context
            .read<GetAlbumsBloc>()
            .add(GetArtistAlbumsEvent(artistId: artistId));
        Navigator.pushNamed(context, "/artist-albums",
            arguments: {"name": artistName, "largeImageUrl": imageUrl});
        debugPrint("Artist name: $artistName");
      },
      child: Padding(
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
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade200,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArtistGrid extends StatelessWidget {
  const ArtistGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isLandscapeOrTablet = constraints.maxWidth > 500;
      final crossAxisCount = isLandscapeOrTablet ? 3 : 2;

      return BlocConsumer<ArtistBloc, ArtistState>(
        listener: (context, state) {
          if (state.isError && !state.isLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                margin: const EdgeInsets.only(
                  bottom: 80,
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
          return state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 3 / 5,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 15.0,
                    mainAxisExtent: 180,
                  ),
                  itemCount: state.artists.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomArtistWidget(
                      artistId: state.artists[index].id,
                      artistName: state.artists[index].name,
                      imageUrl: state.artists[index].largeImageUrl,
                    );
                  },
                );
        },
      );
    });
  }
}
