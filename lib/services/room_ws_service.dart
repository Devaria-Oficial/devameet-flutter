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

  void onAddUser(String link, dynamic callbackOnTrack);
  void onCallMade(String link, dynamic callbackOnTrack);
  void onAnswerMade(String link);
  void onRemoveUser(String link, dynamic callbackRemoveUser);

  Future<void> disposeRTC();
}

abstract class DEvents {
  static const join = "join";
  static const update_user_list = '-update-user-list';
  static const move = 'move';
  static final toggl_mute = 'toggl-mute-user';
  static final add_user = "-add-user";
  static final call_user = "call-user";
  static final call_made = 'call-made';
  static final make_answer = "make-answer";
  static final answer_made = "answer-made";
  static final remove_user = "-remove-user";
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
      final rtpSender =
          await peerConnection.addTrack(track, localStreamProxy!.stream);
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

  @override
  void onAddUser(String link, callbackOnTrack) {
    socketService.on("$link${DEvents.add_user}", (data) async {
      final clientId = data["user"];

      await _addPeerConnection(clientId, callbackOnTrack);

      final selectedPeerConnection =
          peerConnectionService.peerConnections[clientId];

      final Map<String, dynamic> _contraints = {
        'mandatory': {'OfferToReceiveAudio': true, 'OfferToReceiveVideo': true},
        'optional': []
      };

      final offer = await selectedPeerConnection?.createOffer(_contraints);
      await selectedPeerConnection?.setLocalDescription(offer!);

      final event = {
        "link": link,
        "to": clientId,
        "offer": {"sdp": offer!.sdp, "type": offer!.type}
      };

      socketService.emit(DEvents.call_user, event);
    });
  }

  @override
  void onCallMade(String link, callbackOnTrack) {
    socketService.on(DEvents.call_made, (data) async {
      var selectedPeerConnection =
          peerConnectionService.peerConnections[data['socket']];

      if (selectedPeerConnection == null) {
        await _addPeerConnection(data['socket'], callbackOnTrack);
        selectedPeerConnection =
            peerConnectionService.peerConnections[data['socket']];
      }

      final Map<String, dynamic> _contraints = {
        'mandatory': {'OfferToReceiveAudio': true, 'OfferToReceiveVideo': true},
        'optional': []
      };

      String sdp = data["offer"]["sdp"];
      String type = data["offer"]["type"];

      rtc.RTCSessionDescription descriptionRemote =
          rtc.RTCSessionDescription(sdp, type);
      selectedPeerConnection?.setRemoteDescription(descriptionRemote);
      final answer = await selectedPeerConnection?.createAnswer(_contraints);
      selectedPeerConnection?.setLocalDescription(answer!);

      final event = {
        "link": link,
        "to": data['socket'],
        "answer": {"sdp": answer?.sdp, "type": answer?.type}
      };

      socketService.emit(DEvents.make_answer, event);
    });
  }

  @override
  void onAnswerMade(String link) {
    socketService.on(DEvents.answer_made, (data) async {
      final String clientId = data["socket"];

      final selectedPeerConnection =
          peerConnectionService.peerConnections[clientId];

      if (selectedPeerConnection == null) return;

      String sdp = data["answer"]["sdp"];
      String type = data["answer"]["type"];

      rtc.RTCSessionDescription descriptionRemote =
          rtc.RTCSessionDescription(sdp, type);


      selectedPeerConnection?.setRemoteDescription(descriptionRemote);

      if (selectedPeerConnection?.iceConnectionState != null) return;

      final Map<String, dynamic> _constraints = {
        'mandatory': {
          'OfferToReceiveAudio': true,
          'OfferToReceiveVideo': true,
        },
        'optional': [],
      };

      final offer = await selectedPeerConnection?.createOffer(_constraints);
      await selectedPeerConnection?.setLocalDescription(offer!);

      final event = {
        "link": link,
        "to": clientId,
        "offer": {"sdp": offer!.sdp, "type": offer!.type}
      };

      socketService.emit(DEvents.call_user, event);

    });
  }

  @override
  void onRemoveUser(String link, dynamic callbackRemoveUser) {
    socketService.on("$link${DEvents.remove_user}", (data) async {
      final String clientId = data["socket"];

      final selectedPeerConnection = peerConnectionService.peerConnections[clientId];

      if(selectedPeerConnection == null) return;

      selectedPeerConnection.dispose();
      peerConnectionService.peerConnections.remove(clientId);

      callbackRemoveUser(clientId);
    });
  }

  @override
  Future<void> disposeRTC() async {
    try {
      peerConnectionService.local?.renderer.srcObject = null;
      await peerConnectionService.local?.renderer.dispose();

      for (var remote in peerConnectionService.remotes) {
        remote?.renderer.srcObject = null;
        await remote?.renderer.dispose();
      }

      for (var sender in peerConnectionService.senders) {
        await sender.dispose();
      }

      for (var peerConnection in peerConnectionService.peerConnections.entries) {
        await peerConnection.value.dispose();
      }

      peerConnectionService.local = null;
      peerConnectionService.remotes.clear();
      peerConnectionService.peerConnections.clear();
      peerConnectionService.senders.clear();

    } catch (e) {}
  }
}
