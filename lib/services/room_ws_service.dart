import 'package:devameet_flutter/models/room_model.dart';
import 'package:devameet_flutter/models/user_model.dart';
import 'package:devameet_flutter/services/peer_connection_service.dart';
import 'package:devameet_flutter/services/socket_service.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as rtc;

abstract class RoomWsService {
  void connect();
  void disconnect();

  void joinRoom(String link, UserModel user, dynamic callbackOnTrack);
  void onUpdateUserList(
      String link, UserModel user, dynamic callback, dynamic callbackOnTrack);
  void move(String link, String userId, int x, int y, String orientation);
  void toggleMute(String link, UserModel user, bool muted);
}

abstract class DEvents {
  static const join = "join";
  static const update_user_list = '-update-user-list';
  static const move = 'move';
  static final toggl_mute = 'toggl-mute-user';
}

class RoomWsServiceImpl implements RoomWsService {
  final SocketService socketService;
  final PeerConnectionService peerConnectionService;

  RoomWsServiceImpl(
      {required this.socketService, required this.peerConnectionService});

  @override
  void connect() {
    socketService.connect();
  }

  @override
  void disconnect() {
    socketService.disconnect();
  }

  @override
  void joinRoom(String link, UserModel user, dynamic callbackOnTrack) async {
    socketService.emit(DEvents.join, {"link": link, "userId": user.id});

    StreamProxy? localStreamProxy = peerConnectionService.local;
    localStreamProxy ??= await peerConnectionService
        .createStreamProxy((await peerConnectionService.generateLocalStream()));
    peerConnectionService.local ??= localStreamProxy;

    callbackOnTrack(user.id, localStreamProxy);
  }

  @override
  void onUpdateUserList(
      String link, UserModel user, callback, dynamic callbackOnTrack) {
    socketService.on('$link${DEvents.update_user_list}', (data) async {
      final players = List<PlayerModel>.from(
          data['users'].map((user) => PlayerModel.fromJson(user)));
      callback(players);

      for (var player in players) {
        if (player.userId == user.id) continue;

        await _addPeerConnection(player.clientId, callbackOnTrack);
      }
    });
  }

  Future<void> _addPeerConnection(
      String clientId, dynamic callbackOnTrack) async {
    if (peerConnectionService.peerConnections[clientId] != null) return;

    final peerConnection =
        await peerConnectionService.createPeerConnection(clientId);

    StreamProxy? localStreamProxy = peerConnectionService.local;
    localStreamProxy ??= await peerConnectionService
        .createStreamProxy((await peerConnectionService.generateLocalStream()));
    peerConnectionService.local ??= localStreamProxy;

    localStreamProxy.stream.getTracks().forEach((track) async {
      final rtpSender = await peerConnection.addTrack(track, localStreamProxy!.stream);
      peerConnectionService.senders.add(rtpSender);
    });

    peerConnection?.onConnectionState = (state) {
      print("Peer connection state changed");
      print(state);
    };

    peerConnection.onTrack = (rtc.RTCTrackEvent event) async {
      final stream = event.streams.first;
      final streamProxy = await peerConnectionService.createStreamProxy(stream);
      peerConnectionService.remotes.add(streamProxy);

      callbackOnTrack(clientId, streamProxy);
    };

  }

  @override
  void move(String link, String userId, int x, int y, String orientation) {
    final event = {
      "link": link,
      "userId": userId,
      "x": x,
      "y": y,
      "orientation": orientation
    };

    socketService.emit(DEvents.move, event);
  }

  @override
  void toggleMute(String link, UserModel user, bool muted) {
    final event = {"userId": user.id, "link": link, "muted": muted};

    socketService.emit(DEvents.toggl_mute, event);
  }
}
