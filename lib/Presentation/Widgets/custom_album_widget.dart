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
  final List<CustomAlbumWidget> albums = [
    const CustomAlbumWidget(
      imageUrl:
          'https://images.pexels.com/photos/6867603/pexels-photo-6867603.jpeg?auto=compress&cs=tinysrgb&w=600',
      albumName: 'Thriller',
      artistName: 'Michael Jackson',
    ),
    const CustomAlbumWidget(
      imageUrl:
          'https://images.pexels.com/photos/6867603/pexels-photo-6867603.jpeg?auto=compress&cs=tinysrgb&w=600',
      albumName: 'Back in Black',
      artistName: 'AC/DC',
    ),
    const CustomAlbumWidget(
      imageUrl:
          'https://images.pexels.com/photos/6867603/pexels-photo-6867603.jpeg?auto=compress&cs=tinysrgb&w=600',
      albumName: 'Dark Side of the Moon',
      artistName: 'Pink Floyd',
    ),
    const CustomAlbumWidget(
      imageUrl:
          'https://images.pexels.com/photos/6867603/pexels-photo-6867603.jpeg?auto=compress&cs=tinysrgb&w=600',
      albumName: 'Abbey Road',
      artistName: 'The Beatles',
    ),
  ];

  AlbumGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscapeOrTablet = constraints.maxWidth > 600;
        final crossAxisCount = isLandscapeOrTablet ? 4 : 2;

        return BlocBuilder<GetAlbumsBloc, GetAlbumsState>(
          builder: (context, state) {
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 3 / 5,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 15.0,
                mainAxisExtent: 180,
              ),
              itemCount: albums.length,
              itemBuilder: (context, index) {
                // return CustomAlbumWidget(
                //   imageUrl: albums[index]['imageUrl'] ?? '',
                //   albumName: albums[index]['albumName'] ?? '',
                //   artistName: albums[index]['artistName'] ?? '',
                // );
                return albums[index];
              },
            );
          },
        );
      },
    );
  }
}

class AlbumGrid2 extends StatelessWidget {
  AlbumGrid2({super.key});

  final List<CustomAlbumWidget> albums = [
    const CustomAlbumWidget(
      imageUrl:
          'https://images.pexels.com/photos/6867603/pexels-photo-6867603.jpeg?auto=compress&cs=tinysrgb&w=600',
      albumName: 'Thriller',
      artistName: 'Michael Jackson',
    ),
    const CustomAlbumWidget(
      imageUrl:
          'https://images.pexels.com/photos/6867603/pexels-photo-6867603.jpeg?auto=compress&cs=tinysrgb&w=600',
      albumName: 'Back in Black',
      artistName: 'AC/DC',
    ),
    const CustomAlbumWidget(
      imageUrl:
          'https://images.pexels.com/photos/6867603/pexels-photo-6867603.jpeg?auto=compress&cs=tinysrgb&w=600',
      albumName: 'Dark Side of the Moon',
      artistName: 'Pink Floyd',
    ),
    const CustomAlbumWidget(
      imageUrl:
          'https://images.pexels.com/photos/6867603/pexels-photo-6867603.jpeg?auto=compress&cs=tinysrgb&w=600',
      albumName: 'Abbey Road',
      artistName: 'The Beatles',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      // color: Colors.brown,
      height: screenHeight * 0.4,
      width: screenWidth,
      child: GridView.extent(
        // physics: const NeverScrollableScrollPhysics(),
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        shrinkWrap: true,
        children: albums,
      ),
    );
  }
}
