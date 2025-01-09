import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.12,
      width: width * 0.9,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.black.withOpacity(0.1),
          Colors.black.withOpacity(0.2),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                selectedIndex = 0;
              });
            },
            icon: Icon(
              Icons.home,
              size: selectedIndex == 0 ? 36 : 24,
              color: selectedIndex == 0 ? Colors.white : Colors.grey,
            ),
            iconSize: selectedIndex == 0 ? 36 : 24,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                selectedIndex = 1;
              });
            },
            icon: Icon(
              Icons.search,
              size: selectedIndex == 1 ? 36 : 24,
            ),
            iconSize: selectedIndex == 1 ? 36 : 24,
            color: selectedIndex == 1 ? Colors.white : Colors.grey,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                selectedIndex = 2;
              });
            },
            icon: Icon(
              Icons.album,
              size: selectedIndex == 2 ? 36 : 24,
            ),
            iconSize: selectedIndex == 2 ? 36 : 24,
            color: selectedIndex == 2 ? Colors.white : Colors.grey,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                selectedIndex = 3;
              });
            },
            icon: Icon(
              Icons.person,
              size: selectedIndex == 3 ? 36 : 24,
            ),
            iconSize: selectedIndex == 3 ? 36 : 24,
            color: selectedIndex == 3 ? Colors.white : Colors.grey,
          ),
        ],
      ),
    );
  }
}
