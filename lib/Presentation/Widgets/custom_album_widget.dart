import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop_2/Data/Model/album.dart';
import 'package:non_stop_2/Domain/bloc/album_bloc/get_albums_bloc.dart';
import 'package:non_stop_2/Domain/bloc/track_bloc/track_bloc.dart';

class CustomAlbumWidget extends StatelessWidget {
  final Album album;

  const CustomAlbumWidget({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<TrackBloc>().add(GetTracksByAlbumEvent(albumId: album.id));
        Navigator.pushNamed(context, "/album-tracks", arguments: {
          "name": album.name,
          "largeImageUrl": album.largeImageUrl,
          "artist": album.artist,
          "releaseDate": album.date,
          "smallImageUrl": album.smallImageUrl,
        });
      },
      child: Container(
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
                    album.largeImageUrl,
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
                    album.name.length > 20
                        ? '${album.name.substring(0, 17)}...'
                        : album.name,
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
            Expanded(
              flex: 20,
              child: Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    album.artist.length > 20
                        ? '${album.artist.substring(0, 17)}...'
                        : album.artist,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade400,
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
                        album: state.albumsList[index],
                      );
                    },
                  );
          },
        );
      },
    );
  }
}
