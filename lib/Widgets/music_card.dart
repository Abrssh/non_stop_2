import 'package:flutter/material.dart';

class MusicCard extends StatelessWidget {
  const MusicCard({super.key});

  @override
  Widget build(BuildContext context) {
    // return SizedBox(
    //   width: 200,
    //   height: 200,
    //   child: Align(
    //     alignment: Alignment.center,
    //     child: Container(
    //       decoration: BoxDecoration(
    //           image: const DecorationImage(
    //               image: NetworkImage(
    //                   "https://images.pexels.com/photos/3574678/pexels-photo-3574678.jpeg?auto=compress&cs=tinysrgb&w=600"),
    //               fit: BoxFit.cover,
    //               alignment: Alignment.bottomLeft),
    //           borderRadius: BorderRadius.circular(10)),
    //       child: Center(
    //           child: ElevatedButton(
    //               onPressed: () {}, child: const Text("Press Me"))),
    //     ),
    //   ),
    // );
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: 220,
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            "https://images.pexels.com/photos/3574678/pexels-photo-3574678.jpeg?auto=compress&cs=tinysrgb&w=600",
            fit: BoxFit.cover,
            alignment: Alignment.bottomLeft,
          ),
        ),
      ),
    );
  }
}
