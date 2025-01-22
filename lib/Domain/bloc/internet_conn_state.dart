part of 'internet_conn_bloc.dart';

@immutable
sealed class InternetConnState {
  final String connType;
  const InternetConnState({required this.connType});
}

final class InternetConnInitial extends InternetConnState {
  final InternetConnection _internetConnection;
  const InternetConnInitial()
      : _internetConnection = InternetConnection.loading,
        super(connType: "Initial");
  InternetConnection get internetConnection => _internetConnection;
}

final class InternetConnLoading extends InternetConnState {
  final InternetConnection _internetConnection;
  const InternetConnLoading()
      : _internetConnection = InternetConnection.loading,
        super(connType: "Loading");
  InternetConnection get internetConnection => _internetConnection;
}

final class InternetConnConnected extends InternetConnState {
  final InternetConnection _internetConnection;
  final ConnectionType _connectionType;
  const InternetConnConnected({required ConnectionType connectionType})
      : _connectionType = connectionType,
        _internetConnection = InternetConnection.connected,
        super(connType: "Connected");
  InternetConnection get internetConnection => _internetConnection;
  ConnectionType get connectionType => _connectionType;
}

final class InternetConnDisconnected extends InternetConnState {
  final InternetConnection _internetConnection;
  const InternetConnDisconnected()
      : _internetConnection = InternetConnection.disconnected,
        super(connType: "Disconnected");
  InternetConnection get internetConnection => _internetConnection;
}
