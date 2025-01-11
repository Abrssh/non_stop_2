import 'package:flutter/material.dart';

class CustomTrackCard extends StatelessWidget {
  final double width, height;
  final bool isFavorite;
  final String trackName, artistName;

  const CustomTrackCard(
      {super.key,
      required this.width,
      required this.height,
      required this.trackName,
      required this.artistName,
      required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        color: Colors.transparent,
        child: Flex(direction: Axis.horizontal, children: [
          Expanded(
            flex: 20,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  'https://images.pexels.com/photos/17573962/pexels-photo-17573962/free-photo-of-portrait-of-woman-holding-vinyl-record-to-her-face.jpeg?auto=compress&cs=tinysrgb&w=600',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          const Spacer(flex: 2),
          Expanded(
            flex: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trackName.length > 20
                        ? '${trackName.substring(0, 17)}...'
                        : trackName,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 10,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        artistName.length > 20
                            ? '${artistName.substring(0, 17)}...'
                            : artistName,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Spacer(flex: 8),
          Expanded(
            flex: 20,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
