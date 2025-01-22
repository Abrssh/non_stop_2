part of 'internet_conn_bloc.dart';

@immutable
sealed class InternetConnEvent {
  final String param;
  const InternetConnEvent({required this.param});
}

class CheckInternetConnEvent extends InternetConnEvent {
  const CheckInternetConnEvent({required String param}) : super(param: param);
}

class ListenToInternetConnEvent extends InternetConnEvent {
  const ListenToInternetConnEvent({required String param})
      : super(param: param);
}
