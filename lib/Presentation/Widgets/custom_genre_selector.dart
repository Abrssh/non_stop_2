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
    return BlocListener<TrackBloc, TrackState>(
      listener: (context, state) {
        // if (!state.isLoading) {
        //   if (selectedIndex == 0) {
        //     context
        //         .read<TrackBloc>()
        //         .add(const SearchTracksEvent(query: "Trending Right Now"));
        //   } else if (selectedIndex == 1) {
        //     context
        //         .read<TrackBloc>()
        //         .add(const SearchTracksEvent(query: "Rock"));
        //   } else if (selectedIndex == 2) {
        //     context
        //         .read<TrackBloc>()
        //         .add(const SearchTracksEvent(query: "Pop"));
        //   } else if (selectedIndex == 3) {
        //     context
        //         .read<TrackBloc>()
        //         .add(const SearchTracksEvent(query: "Hip Hop"));
        //   } else if (selectedIndex == 4) {
        //     context
        //         .read<TrackBloc>()
        //         .add(const SearchTracksEvent(query: "Jazz"));
        //   } else if (selectedIndex == 5) {
        //     context
        //         .read<TrackBloc>()
        //         .add(const SearchTracksEvent(query: "Electronic"));
        //   } else if (selectedIndex == 6) {
        //     context
        //         .read<TrackBloc>()
        //         .add(const SearchTracksEvent(query: "Country"));
        //   }
        // }
      },
      child: SizedBox(
        height: 35,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            TextButton(
              onPressed: () => setState(() {
                selectedIndex = 0;
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
                });
              },
              child: const Text('Country',
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}
