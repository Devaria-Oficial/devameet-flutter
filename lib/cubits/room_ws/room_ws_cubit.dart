import 'package:devameet_flutter/models/auth_model.dart';
import 'package:devameet_flutter/models/room_model.dart';
import 'package:devameet_flutter/models/user_model.dart';
import 'package:devameet_flutter/services/room_render_service.dart';
import 'package:devameet_flutter/services/room_ws_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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

  void start(RoomModel room, UserModel user, double width) async {

    this._avatarAssets = await roomRenderService.getDevameetAssets(assetType: "Avatar");
    _width = width;
    _user = user;

    roomWsService.connect();
    roomWsService.joinRoom(room.link, user);
    roomWsService.onUpdateUserList(room.link, _onUpdateUserList);
  }

  void _onUpdateUserList(List<PlayerModel> players) {
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


    print(newOrientation);
    print(x);
    print(y);

  }

}