import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop_2/Domain/bloc/track_bloc/track_bloc.dart';
import 'package:non_stop_2/Presentation/Widgets/custom_track_list.dart';

class TrackPage extends StatelessWidget {
  final double height;
  const TrackPage({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrackBloc, TrackState>(
      listener: (context, state) {
        if (state.isError && !state.isLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              margin: const EdgeInsets.only(
                bottom: 80, // Adjust based on your bottom nav height
                left: 10,
                right: 10,
              ),
              behavior: SnackBarBehavior.floating,
              content: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return CustomTrackList(height: height, tracks: state.tracks);
      },
    );
  }
}
