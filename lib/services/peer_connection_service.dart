import 'package:flutter_webrtc/flutter_webrtc.dart' as rtc;

class StreamProxy {
  final rtc.MediaStream stream;
  final rtc.RTCVideoRenderer renderer;

  StreamProxy({required this.stream, required this.renderer});
}

class PeerConnectionService {
  StreamProxy? local;
  List<StreamProxy> remotes = [];

  List<rtc.RTCRtpSender> senders = [];
  Map<String, rtc.RTCPeerConnection> peerConnections = {};


  Future<StreamProxy> createStreamProxy(rtc.MediaStream stream) async {
    final renderer = rtc.RTCVideoRenderer();
    await renderer.initialize();
    renderer.srcObject = stream;

    return StreamProxy(stream: stream, renderer: renderer);
  }

  Future<rtc.MediaStream> generateLocalStream() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
    };

    final stream =
        await rtc.navigator.mediaDevices.getUserMedia(mediaConstraints);
    return stream;
  }

  Future<rtc.RTCPeerConnection> createPeerConnection(String clientId) async {
    final peerConnection = await rtc.createPeerConnection({
      "iceServers": [
        {"urls": 'stun:stun.l.google.com:19302'}
      ],
    });

    peerConnections[clientId] = peerConnection;

    return peerConnection;
  }
}
