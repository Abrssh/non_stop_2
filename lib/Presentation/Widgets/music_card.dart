import 'package:flutter/material.dart';

class MusicCard extends StatelessWidget {
  final String imageUrl;
  const MusicCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: 210,
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(1),
              spreadRadius: -6,
              blurRadius: 7,
              offset: const Offset(0, 0),
            ),
          ],
          // color: Colors.white,
        ),
        child: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                alignment: Alignment.bottomLeft,
                width: 210,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                padding: const EdgeInsets.only(right: 20),
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: 25,
                )),
          )
        ]),
      ),
    );
  }
}
