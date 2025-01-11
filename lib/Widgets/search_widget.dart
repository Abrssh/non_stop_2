import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Flex(direction: Axis.horizontal, children: [
        const Spacer(
          flex: 2,
        ),
        Expanded(
            flex: 12,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(width: 1, color: Colors.white.withOpacity(0.2)),
              ),
              child: Align(
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.menu_open_sharp,
                      size: 20,
                      color: Colors.white.withOpacity(0.8),
                    )),
              ),
            )),
        const Spacer(
          flex: 3,
        ),
        Expanded(
          flex: 80,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(width: 1, color: Colors.white.withOpacity(0.2)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search,
                        color: Colors.white.withOpacity(0.5), size: 25),
                    prefixIconConstraints: const BoxConstraints(minWidth: 35),
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5), fontSize: 13),
                    fillColor: Colors.white),
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5), fontSize: 13),
              ),
            ),
          ),
        ),
        const Spacer(flex: 3),
      ]),
    );
  }
}
