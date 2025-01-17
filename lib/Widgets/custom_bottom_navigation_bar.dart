import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop_2/cubit/bottom_navigation_cubit.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  // int selectedIndex = 0;

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
          BlocListener<BottomNavigationCubit, BottomNavigationState>(
            listener: (context, state) {
              debugPrint("Listening to state changes: ${state.currentIndex}");
            },
            child: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    context.read<BottomNavigationCubit>().setIndex(0);
                  },
                  icon: Icon(
                    Icons.home,
                    size: context
                                .read<BottomNavigationCubit>()
                                .state
                                .currentIndex ==
                            0
                        ? 32
                        : 24,
                    color: context
                                .read<BottomNavigationCubit>()
                                .state
                                .currentIndex ==
                            0
                        ? Colors.white
                        : Colors.grey,
                  ),
                );
              },
            ),
          ),
          BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  BlocProvider.of<BottomNavigationCubit>(context).setIndex(1);
                },
                icon: Icon(
                  Icons.search,
                  size: context
                              .read<BottomNavigationCubit>()
                              .state
                              .currentIndex ==
                          1
                      ? 32
                      : 24,
                ),
                color:
                    context.read<BottomNavigationCubit>().state.currentIndex ==
                            1
                        ? Colors.white
                        : Colors.grey,
              );
            },
          ),
          BlocConsumer<BottomNavigationCubit, BottomNavigationState>(
            listener: (context, state) {
              debugPrint("Listen 2: ${state.currentIndex}");
            },
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<BottomNavigationCubit>().setIndex(2);
                  setState(() {});
                },
                icon: Icon(
                  Icons.album,
                  size: context
                              .read<BottomNavigationCubit>()
                              .state
                              .currentIndex ==
                          2
                      ? 32
                      : 24,
                ),
                color:
                    context.read<BottomNavigationCubit>().state.currentIndex ==
                            2
                        ? Colors.white
                        : Colors.grey,
              );
            },
            buildWhen: (previous, current) {
              debugPrint(
                  "Bw: ${previous.currentIndex} ${current.currentIndex}");
              // return
              return previous.currentIndex != current.currentIndex;
            },
            listenWhen: (previous, current) =>
                (previous.currentIndex - current.currentIndex).abs() > 1,
          ),
          BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<BottomNavigationCubit>().setIndex(3);
                },
                icon: Icon(
                  Icons.person,
                  size: state.currentIndex == 3 ? 32 : 24,
                ),
                color: state.currentIndex == 3 ? Colors.white : Colors.grey,
              );
            },
          )
        ],
      ),
    );
  }
}
