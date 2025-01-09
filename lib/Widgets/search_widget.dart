import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Flex(direction: Axis.horizontal, children: [
      const Spacer(
        flex: 2,
      ),
      Expanded(
          flex: 25,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
                border:
                    Border.all(width: 1, color: Colors.white.withOpacity(0.2)),
              ),
              height: 50,
              child: Align(
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.menu_open_sharp,
                      size: 30,
                      color: Colors.white.withOpacity(0.8),
                    )),
              ),
            ),
          )),
      const Spacer(
        flex: 7,
      ),
      Expanded(
        flex: 100,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(width: 1, color: Colors.white.withOpacity(0.2)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                  icon:
                      Icon(Icons.search, color: Colors.white.withOpacity(0.5)),
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  fillColor: Colors.white),
              style: TextStyle(color: Colors.white.withOpacity(0.5)),
            ),
          ),
        ),
      ),
    ]);
  }
}
