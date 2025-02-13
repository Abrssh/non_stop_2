import 'package:flutter/material.dart';
import 'package:non_stop_2/Presentation/Widgets/custom_album_widget.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key});

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
            Spacer(
              flex: 1,
            ),
            Flexible(
              flex: 25,
              child: AlbumGrid(),
            ),
            Spacer(
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }
}
