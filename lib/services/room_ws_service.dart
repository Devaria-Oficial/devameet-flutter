import 'package:devameet_flutter/models/room_model.dart';
import 'package:devameet_flutter/models/user_model.dart';
import 'package:devameet_flutter/services/peer_connection_service.dart';
import 'package:devameet_flutter/services/socket_service.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as rtc;

abstract class RoomWsService {
  void connect();
  void disconnect();

  void joinRoom(String link, UserModel user, dynamic callback);
  void onUpdateUserList(String link, UserModel user,
      dynamic callback_render_players, dynamic callback_on_track);

  void move(String link, String userId, int x, int y, String orientation);

  void onCallMade(String link, dynamic callback_on_track);
  void onAddUser(String link, dynamic call_back_on_track);
  void onRemoveUser(String link);
  void onAnswerMade(String link);

  Future<void> dispose();
}

abstract class DEvents {
  static const join = "join";
  static const update_user_list = '-update-user-list';
  static const move = 'move';

  static const call_made = 'call-made';
  static const make_answer = "make-answer";
  static const add_user = "-add-user";
  static const remove_user = "-remove-user";
  static const answer_made = "answer-made";
  static const call_user = "call-user";
}

class RoomWsServiceImpl implements RoomWsService {
  final SocketService socketService;
  final PeerConnectionServiceImpl peerConnectionService;

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
  void joinRoom(String link, UserModel user, dynamic callback) async {
    socketService.emit(DEvents.join, {"link": link, "userId": user.id});

    StreamProxy? localStreamProxy = peerConnectionService.local;
    localStreamProxy ??= await peerConnectionService
        .createStreamProxy((await peerConnectionService.generateLocalStream()));
    peerConnectionService.local = localStreamProxy;

    callback(user.id, localStreamProxy);
  }

  @override
  void onUpdateUserList(
      String link, UserModel user, callback_render_players, callback_on_track) {
    socketService.on('$link${DEvents.update_user_list}', (data) async {
      final players = List<PlayerModel>.from(
          data['users'].map((user) => PlayerModel.fromJson(user)));

      for (var player in players) {
        if (player.userId == user.id) continue;
        await addPeerConnection(player.clientId, callback_on_track);
      }

      callback_render_players(players);
    });
  }

  Future<void> addPeerConnection(
      String clientId, dynamic callback_on_track) async {
    print("entrando no addPeerConnection");
    print(peerConnectionService.peerConnections);
    print(clientId);

    if (peerConnectionService.peerConnections[clientId] != null) return;

    final peerConnection =
        await peerConnectionService.createPeerConnection(clientId);

    print(peerConnectionService.peerConnections);

    StreamProxy? localStreamProxy = peerConnectionService.local;
    localStreamProxy ??= await peerConnectionService
        .createStreamProxy((await peerConnectionService.generateLocalStream()));

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
      callback_on_track!(clientId, streamProxy);
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
  void onCallMade(String link, dynamic callback_on_track) {
    socketService.on(DEvents.call_made, (data) async {
      print("CALL MADE");
      print(data['socket']);
      print(peerConnectionService.peerConnections);

      var selectedPeerConnection =
          peerConnectionService.peerConnections[data['socket']];

      // if (selectedPeerConnection == null) return;

      if (selectedPeerConnection == null) {
        await addPeerConnection(data['socket'], callback_on_track);
        selectedPeerConnection =
            peerConnectionService.peerConnections[data['socket']];
      }

      final Map<String, dynamic> _constraints = {
        'mandatory': {
          'OfferToReceiveAudio': true,
          'OfferToReceiveVideo': true,
        },
        'optional': [],
      };

      String sdp = data["offer"]["sdp"];
      String type = data["offer"]["type"];

      rtc.RTCSessionDescription descriptionRemote =
          rtc.RTCSessionDescription(sdp, type);
      selectedPeerConnection?.setRemoteDescription(descriptionRemote);
      final answer = await selectedPeerConnection?.createAnswer(_constraints);
      selectedPeerConnection?.setLocalDescription(answer!);

      final payload = {
        "link": link,
        "to": data['socket'],
        "answer": {"sdp": answer?.sdp, "type": answer?.type}
      };

      socketService.emit(DEvents.make_answer, payload);
    });
  }

  @override
  void onAddUser(String link, dynamic callback_on_track) {
    socketService.on("$link${DEvents.add_user}", (data) async {
      final clientId = data["user"];
      print("EXECUTANDO ON ADD USER");
      await addPeerConnection(clientId, callback_on_track);

      final selectedPeerConnection =
      peerConnectionService.peerConnections[clientId];

      final Map<String, dynamic> _constraints = {
        'mandatory': {
          'OfferToReceiveAudio': true,
          'OfferToReceiveVideo': true,
        },
        'optional': [],
      };

      final offer = await selectedPeerConnection?.createOffer(_constraints);
      await selectedPeerConnection?.setLocalDescription(offer!);

      final payload = {
        "link": link,
        "to": clientId,
        "offer": {"sdp": offer!.sdp, "type": offer!.type}
      };

      socketService.emit(DEvents.call_user, payload);

    });
  }

  @override
  void onRemoveUser(String link) {
    socketService.on("$link${DEvents.remove_user}", (data) {
      final String clientId = data["socketId"];

      final selectedPeerConnection =
          peerConnectionService.peerConnections[clientId];
      if (selectedPeerConnection == null) return;

      peerConnectionService.peerConnections.remove(clientId);
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

      final payload = {
        "link": link,
        "to": clientId,
        "offer": {"sdp": offer!.sdp, "type": offer!.type}
      };

      socketService.emit(DEvents.call_user, payload);
    });
  }

  @override
  Future<void> dispose() async {
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
