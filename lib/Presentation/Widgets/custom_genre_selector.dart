import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop_2/Domain/bloc/track_bloc/track_bloc.dart';

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
      height: 35,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          TextButton(
            onPressed: () => setState(() {
              selectedIndex = 0;
              context
                  .read<TrackBloc>()
                  .add(const SearchTracksEvent(query: "Best Ethiopian Songs"));
            }),
            style: selectedIndex == 0
                ? ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 83, 34, 161)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    visualDensity: const VisualDensity(vertical: -3),
                  )
                : null,
            child: const Text(
              "Trending Right Now",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          const SizedBox(width: 10),
          TextButton(
            style: selectedIndex == 1
                ? ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 83, 34, 161)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    visualDensity: const VisualDensity(vertical: -3),
                  )
                : null,
            onPressed: () {
              setState(() {
                selectedIndex = 1;
                context
                    .read<TrackBloc>()
                    .add(const SearchTracksEvent(query: "Best Rock Songs"));
              });
            },
            child: const Text('Rock',
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
          const SizedBox(width: 10),
          TextButton(
            style: selectedIndex == 2
                ? ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 83, 34, 161)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    visualDensity: const VisualDensity(vertical: -3),
                  )
                : null,
            onPressed: () {
              setState(() {
                context
                    .read<TrackBloc>()
                    .add(const SearchTracksEvent(query: "Best Rap Songs"));
                selectedIndex = 2;
              });
            },
            child: const Text('Hip-Hop',
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
          const SizedBox(width: 10),
          TextButton(
            style: selectedIndex == 3
                ? ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 83, 34, 161)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    visualDensity: const VisualDensity(vertical: -3),
                  )
                : null,
            onPressed: () {
              setState(() {
                selectedIndex = 3;
                context
                    .read<TrackBloc>()
                    .add(const SearchTracksEvent(query: "Best Jazz Songs"));
              });
            },
            child: const Text('Jazz',
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
          const SizedBox(width: 10),
          TextButton(
            style: selectedIndex == 4
                ? ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 83, 34, 161)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    visualDensity: const VisualDensity(vertical: -3),
                  )
                : null,
            onPressed: () {
              setState(() {
                selectedIndex = 4;
                context.read<TrackBloc>().add(
                    const SearchTracksEvent(query: "Best Electronic Songs"));
              });
            },
            child: const Text('Electronic',
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
          const SizedBox(width: 10),
          TextButton(
            style: selectedIndex == 5
                ? ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 83, 34, 161)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    visualDensity: const VisualDensity(vertical: -3),
                  )
                : null,
            onPressed: () {
              setState(() {
                selectedIndex = 5;
                context
                    .read<TrackBloc>()
                    .add(const SearchTracksEvent(query: "Best Country Songs"));
              });
            },
            child: const Text('Country',
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
