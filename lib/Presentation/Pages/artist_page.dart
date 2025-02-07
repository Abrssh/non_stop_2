import 'package:flutter/material.dart';
import 'package:non_stop_2/Presentation/Widgets/custom_artist_widget.dart';

class ArtistPage extends StatelessWidget {
  const ArtistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              flex: 10,
              child: Container(
                  color: Colors.white.withValues(alpha: 240),
                  // color: Colors.white.withAlpha(100),
                  child: const ArtistGrid()),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
