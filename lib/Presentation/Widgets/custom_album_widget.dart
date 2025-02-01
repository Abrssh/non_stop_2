import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop_2/Domain/bloc/album_bloc/get_albums_bloc.dart';

class CustomAlbumWidget extends StatelessWidget {
  final String albumName;
  final String artistName;
  final String imageUrl;

  const CustomAlbumWidget({
    Key? key,
    required this.albumName,
    required this.artistName,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.grey.shade300,
      //     width: 1.0,
      //   ),
      //   color: Colors.deepPurple,
      //   borderRadius: BorderRadius.circular(12),
      // ),
      // margin: const EdgeInsets.all(8.0),
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
            flex: 20,
            child: Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                Text(
                  albumName.length > 20
                      ? '${albumName.substring(0, 17)}...'
                      : albumName,
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
          Expanded(
            flex: 20,
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
                    fontSize: 12,
                    color: Colors.grey,
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

class AlbumGrid extends StatelessWidget {
  const AlbumGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscapeOrTablet = constraints.maxWidth > 600;
        final crossAxisCount = isLandscapeOrTablet ? 4 : 2;

        return BlocConsumer<GetAlbumsBloc, GetAlbumsState>(
          listener: (context, state) {
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
                    itemCount: state.albumsList.length,
                    itemBuilder: (context, index) {
                      return CustomAlbumWidget(
                        imageUrl: state.albumsList[index].largeImageUrl,
                        albumName: state.albumsList[index].name,
                        artistName: state.albumsList[index].artist,
                      );
                    },
                  );
          },
        );
      },
    );
  }
}
