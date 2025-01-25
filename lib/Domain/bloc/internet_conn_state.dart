part of 'internet_conn_bloc.dart';

@immutable
sealed class InternetConnState extends Equatable {
  final String connType;
  final bool listening;
  const InternetConnState({required this.connType, this.listening = false});
}

final class InternetConnInitial extends InternetConnState {
  final InternetConnection _internetConnection;
  const InternetConnInitial()
      : _internetConnection = InternetConnection.loading,
        super(connType: "Initial");
  InternetConnection get internetConnection => _internetConnection;

  @override
  List<Object?> get props =>
      [_internetConnection, super.connType, super.listening];
}

final class InternetConnLoading extends InternetConnState {
  final InternetConnection _internetConnection;
  const InternetConnLoading()
      : _internetConnection = InternetConnection.loading,
        super(connType: "Loading");
  InternetConnection get internetConnection => _internetConnection;

  @override
  List<Object?> get props =>
      [_internetConnection, super.connType, super.listening];
}

final class InternetConnConnected extends InternetConnState {
  final InternetConnection _internetConnection;
  final ConnectionType _connectionType;
  const InternetConnConnected(
      {required ConnectionType connectionType, super.listening = false})
      : _connectionType = connectionType,
        _internetConnection = InternetConnection.connected,
        super(connType: "Connected");
  InternetConnection get internetConnection => _internetConnection;
  ConnectionType get connectionType => _connectionType;

  @override
  List<Object?> get props =>
      [_internetConnection, _connectionType, super.connType, super.listening];

  InternetConnConnected copyWith({
    ConnectionType? connectionType,
    bool? listening,
  }) {
    return InternetConnConnected(
      connectionType: connectionType ?? _connectionType,
      listening: listening ?? super.listening,
    );
  }
}

final class InternetConnDisconnected extends InternetConnState {
  final InternetConnection _internetConnection;
  const InternetConnDisconnected({super.listening = false})
      : _internetConnection = InternetConnection.disconnected,
        super(connType: "Disconnected");
  InternetConnection get internetConnection => _internetConnection;
  @override
  List<Object?> get props =>
      [_internetConnection, super.connType, super.listening];
}
