import 'package:flutter/material.dart';
import 'package:non_stop_2/Presentation/Widgets/custom_album_widget.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key});

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
                  color: Colors.white.withOpacity(0.05),
                  child: const AlbumGrid()),
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
