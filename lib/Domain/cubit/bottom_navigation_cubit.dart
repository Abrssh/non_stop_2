import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(BottomNavigationState(currentIndex: 0)) {
    debugPrint('BottomNavigationCubit instantiated');
  }

  void setIndex(int paramIndex) {
    emit(BottomNavigationState(currentIndex: paramIndex));
  }
}
