import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop_2/Domain/bloc/track_bloc/track_bloc.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).orientation == Orientation.landscape
          ? MediaQuery.of(context).size.height * 0.13
          : MediaQuery.of(context).size.height * 0.08,
      child: Flex(direction: Axis.horizontal, children: [
        const Spacer(
          flex: 2,
        ),
        Expanded(
            flex: 15,
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
                      size: 25,
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
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(width: 1, color: Colors.white.withOpacity(0.2)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: TextField(
                // cursorHeight: double.infinity,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white.withOpacity(0.5),
                      size: 18,
                    ),
                    prefixIconConstraints: const BoxConstraints(minWidth: 35),
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5), fontSize: 16),
                    fillColor: Colors.white),
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5), fontSize: 13),
                onSubmitted: (value) {
                  context
                      .read<TrackBloc>()
                      .add(SearchTracksEvent(query: value));
                },
              ),
            ),
          ),
        ),
        const Spacer(flex: 3),
      ]),
    );
  }
}
