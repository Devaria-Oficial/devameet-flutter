import 'package:socket_io_client/socket_io_client.dart' as IO;

abstract class SocketService {
  void connect();
  void disconnect();
  void on(String event, dynamic Function(dynamic) handler);
  void emit(String event, [dynamic, data]);
}

class SocketServiceImpl implements SocketService {
  late IO.Socket socket;

  SocketServiceImpl(String socketUrl) {
    socket = IO.io(
        socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    socket.onError((data) => print("error ao conectar"));
    socket.onConnect((data) => print("socket conectado"));
    socket.onDisconnect((data) => print("socket desconectado"));
  }

  @override
  void emit(String event, [dynamic, data]) {
    socket.emit(event, data);
  }

  @override
  void on(String event, Function(dynamic p1) handler) {
    socket.on(event, handler);
  }

  @override
  void connect() {
    socket.connect();
  }

  @override
  void disconnect() {
    socket.dispose();
  }
}
