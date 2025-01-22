import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop_2/Constant/enums.dart';

part 'internet_conn_event.dart';
part 'internet_conn_state.dart';

class InternetConnBloc extends Bloc<InternetConnEvent, InternetConnState> {
  late final StreamSubscription internetSubscription;
  InternetConnBloc() : super(const InternetConnInitial()) {
    internetSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        add(const ListenToInternetConnEvent(param: "Mobile"));
      } else if (result == ConnectivityResult.wifi) {
        add(const ListenToInternetConnEvent(param: "Wifi"));
      } else {
        add(const ListenToInternetConnEvent(param: "None"));
      }
    });
    on<InternetConnEvent>((event, emit) {
      // debugPrint("Event Recieved: ${event.runtimeType}");
    });
    on<CheckInternetConnEvent>((event, emit) async {
      // debugPrint("Event Recieved2: ${event.param}");
      // debugPrint("Current State: ${state.runtimeType}");
      // if (state == InternetConnInitial()) {
      //   emit(InternetConnLoading());
      //   debugPrint("Emiting Loading");
      // }
      emit(const InternetConnLoading());
      final ConnectivityResult connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.mobile) {
        emit(
            const InternetConnConnected(connectionType: ConnectionType.mobile));
      } else if (connectivityResult == ConnectivityResult.wifi) {
        emit(const InternetConnConnected(connectionType: ConnectionType.wifi));
      } else {
        emit(const InternetConnDisconnected());
      }
    });
    on<ListenToInternetConnEvent>((event, emit) {
      if (event.param == "Mobile") {
        emit(
            const InternetConnConnected(connectionType: ConnectionType.mobile));
      } else if (event.param == "Wifi") {
        emit(const InternetConnConnected(connectionType: ConnectionType.wifi));
      } else {
        emit(const InternetConnDisconnected());
      }
    });
  }

  @override
  Future<void> close() {
    internetSubscription.cancel();
    return super.close();
  }
}
