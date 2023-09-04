import 'package:devameet_flutter/models/auth_model.dart';
import 'package:devameet_flutter/models/room_model.dart';
import 'package:devameet_flutter/models/user_model.dart';
import 'package:devameet_flutter/services/peer_connection_service.dart';
import 'package:devameet_flutter/services/room_render_service.dart';
import 'package:devameet_flutter/services/room_ws_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

part 'room_ws_state.dart';

enum Direction { up, down, left, right}

class RoomWsCubit extends Cubit<RoomWsState> {
  final RoomWsService roomWsService;
  final RoomRenderService roomRenderService;

  RoomWsCubit({
    required this.roomWsService,
    required this.roomRenderService
  }) : super(RoomWsState.initial());

  @override
  Future<void> close() async {
    roomWsService.disconnect();
    return super.close();
  }

  Map<String, DevameetAssetModel>? _avatarAssets;
  List<PlayerModel> _players = [];
  double? _width;
  UserModel? _user;
  RoomModel? _room;

  void start(RoomModel room, UserModel user, double width) async {

    this._avatarAssets = await roomRenderService.getDevameetAssets(assetType: "Avatar");
    _width = width;
    _user = user;
    _room = room;

    roomWsService.connect();
    roomWsService.joinRoom(room.link, user, _onTrack);
    roomWsService.onUpdateUserList(room.link, user, _onUpdateUserList, _onTrack);
    roomWsService.onCallMade(room.link, _onTrack);
    roomWsService.onAddUser(room.link, _onTrack);
    roomWsService.onAnswerMade(room.link);
    roomWsService.onRemoveUser(room.link, _onRemoveUser);
  }

  void _onTrack(String clientId, StreamProxy streamProxy) {
    final playerAudios = Map<String, RTCVideoRenderer>.from(state.playerAudios)..addAll({clientId: streamProxy.renderer});
    emit(state.copyWith(playerAudios: playerAudios));
  }

  void _onRemoveUser(String clientId) {
    _players = _players..removeWhere((player) => player.clientId == clientId);
    _generatePlayerRenderItems();
  }

  void _onUpdateUserList(List<PlayerModel> players) {
    print(players);
    _players = players;
    _generatePlayerRenderItems();
  }

  void _generatePlayerRenderItems() {
    final playerRenderItems = roomRenderService.generatePlayerRoomItems(_avatarAssets!, _players, _width!);
    emit(state.copyWith(playerRenderItems: playerRenderItems));
  }

  void startMove(Direction direction) {
    final localPlayer = _players.firstWhere((player) => player.userId == _user!.id);
    _move(direction, localPlayer);
  }

  void stopMove() {}


  void _move(Direction direction, PlayerModel localPlayer) {
    String newOrientation;
    int x = localPlayer.x;
    int y = localPlayer.y;

    switch (direction) {
      case Direction.up:
        newOrientation = "back";
        if (y > 0) y--;
        break;
      case Direction.down:
        newOrientation = "front";
        if (y < 7) y++;
        break;
      case Direction.left:
        newOrientation = "left";
        if (x > 0) x--;
        break;
      case Direction.right:
        newOrientation = "right";
        if (x < 7) x++;
        break;
    }

    roomWsService.move(_room!.link, localPlayer.userId, x, y, newOrientation);
  }

  void toggleAudio() {
    bool _muted = !state.muted;
    emit(state.copyWith(muted: _muted));
    roomWsService.toggleMute(_room!.link, _user!, _muted);
  }

}