import 'package:flutter/material.dart';

class CustomGenreSelector extends StatefulWidget {
  const CustomGenreSelector({super.key});

  @override
  State<CustomGenreSelector> createState() => _CustomGenreSelectorState();
}

class _CustomGenreSelectorState extends State<CustomGenreSelector> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              width: 150,
              height: 10,
              // margin: const EdgeInsets.all(10),
              decoration: selectedIndex == 0
                  ? const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(81, 41, 165, 1),
                          Color.fromARGB(125, 88, 38, 196),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    )
                  : null,
              child: Align(
                  child: TextButton(
                      onPressed: () => setState(() {
                            selectedIndex = 0;
                          }),
                      child: const Text(
                        "Trending Right Now",
                        style: TextStyle(color: Colors.white),
                      ))),
            ),
          ),
          const SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              width: 80,
              decoration: selectedIndex == 1
                  ? const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(81, 41, 165, 1),
                          Color.fromARGB(125, 88, 38, 196),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    )
                  : null,
              child: Align(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child:
                      const Text('Rock', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              width: 80,
              decoration: selectedIndex == 2
                  ? const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(81, 41, 165, 1),
                          Color.fromARGB(125, 88, 38, 196),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    )
                  : null,
              child: Align(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                  child: const Text('Hip-Hop',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              width: 80,
              decoration: selectedIndex == 3
                  ? const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(81, 41, 165, 1),
                          Color.fromARGB(125, 88, 38, 196),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    )
                  : null,
              child: Align(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = 3;
                    });
                  },
                  child:
                      const Text('Jazz', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              width: 90,
              decoration: selectedIndex == 4
                  ? const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(81, 41, 165, 1),
                          Color.fromARGB(125, 88, 38, 196),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    )
                  : null,
              child: Align(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = 4;
                    });
                  },
                  child: const Text('Electronic',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              width: 80,
              decoration: selectedIndex == 5
                  ? const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(81, 41, 165, 1),
                          Color.fromARGB(125, 88, 38, 196),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    )
                  : null,
              child: Align(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = 5;
                    });
                  },
                  child: const Text('Country',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
