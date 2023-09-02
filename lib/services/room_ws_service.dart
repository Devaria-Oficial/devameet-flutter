

import 'package:devameet_flutter/services/socket_service.dart';

abstract class RoomWsService {
  void connect();
  void disconnect();
}

class RoomWsServiceImpl implements RoomWsService {
  final SocketService socketService;

  RoomWsServiceImpl({required this.socketService});

  @override
  void connect() {
    socketService.connect();
  }

  @override
  void disconnect() {
    socketService.disconnect();
  }

}