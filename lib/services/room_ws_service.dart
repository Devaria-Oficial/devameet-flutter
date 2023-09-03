

import 'package:devameet_flutter/models/room_model.dart';
import 'package:devameet_flutter/models/user_model.dart';
import 'package:devameet_flutter/services/socket_service.dart';

abstract class RoomWsService {
  void connect();
  void disconnect();

  void joinRoom(String link, UserModel user);
  void onUpdateUserList(String link, dynamic callback);
}

abstract class DEvents {
  static const join = "join";
  static const update_user_list = '-update-user-list';
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

  @override
  void joinRoom(String link, UserModel user) {
    socketService.emit(DEvents.join, {"link": link, "userId": user.id});
  }

  @override
  void onUpdateUserList(String link, callback) {
    socketService.on('$link${DEvents.update_user_list}', (data) {
      print(data);
      final players = List<PlayerModel>.from(data['users'].map((user) => PlayerModel.fromJson(user)));
      callback(players);
    });
  }

}