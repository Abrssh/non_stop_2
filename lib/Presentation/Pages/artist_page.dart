import 'package:flutter/material.dart';
import 'package:non_stop_2/Presentation/Widgets/custom_artist_widget.dart';

class ArtistPage extends StatelessWidget {
  const ArtistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Spacer(
              flex: 1,
            ),
            Flexible(
              flex: 20,
              child: ArtistGrid(),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
