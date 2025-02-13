import 'package:flutter/material.dart';
import 'package:non_stop_2/Data/Model/track.dart';
import 'package:non_stop_2/Presentation/Widgets/custom_track_card.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomTrackList extends StatelessWidget {
  final double height;
  final List<Track> tracks;
  final String imageUrl;
  const CustomTrackList(
      {super.key,
      required this.height,
      required this.tracks,
      this.imageUrl = ""});

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return InkWell(
            onTapDown: (details) {
              debugPrint("${details}track url: ${tracks[index].externalUrl}");
              _launchUrl(tracks[index].externalUrl);
            },
            child: CustomTrackCard(
                width: 100,
                height: 80,
                isFavorite: tracks[index].id.hashCode % 7 == 0,
                imageUrl:
                    imageUrl == "" ? tracks[index].smallImageUrl : imageUrl,
                trackName: tracks[index].name,
                artistName: tracks[index].artistName),
          );
        },
        itemCount: tracks.length,
      ),
    );
  }
}
