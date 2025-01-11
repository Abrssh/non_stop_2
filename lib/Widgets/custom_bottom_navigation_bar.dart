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
      height: height * 0.105,
      width: width * 0.9,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(63, 64, 84, 0.9),
        // gradient: const LinearGradient(colors: [
        //   Color.fromRGBO(63, 64, 84, 0.8),
        //   Color.fromRGBO(63, 64, 84, 0.8),
        // ], begin: Alignment.centerLeft, end: Alignment.centerRight),
        borderRadius: BorderRadius.circular(18),
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
              size: selectedIndex == 0 ? 32 : 24,
              color: selectedIndex == 0 ? Colors.white : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                selectedIndex = 1;
              });
            },
            icon: Icon(
              Icons.search,
              size: selectedIndex == 1 ? 32 : 24,
            ),
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
              size: selectedIndex == 2 ? 32 : 24,
            ),
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
              size: selectedIndex == 3 ? 32 : 24,
            ),
            color: selectedIndex == 3 ? Colors.white : Colors.grey,
          ),
        ],
      ),
    );
  }
}
