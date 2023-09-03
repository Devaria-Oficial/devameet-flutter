import 'package:devameet_flutter/components/room/audio_button.dart';
import 'package:devameet_flutter/components/room/players_render.dart';
import 'package:devameet_flutter/components/room/room_lobby.dart';
import 'package:devameet_flutter/cubits/room/room_cubit.dart';
import 'package:devameet_flutter/models/room_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomRender extends StatelessWidget {
  const RoomRender({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCubit, RoomState>(builder: (context, state) {
      return Stack(children: [
        ...state.roomRenderItems
            .map<Widget>((item) => RoomItem(item: item))
            .toList(),
        const PlayersRender(),
        Visibility(
            visible: state.status == RoomStatus.roomBuilt,
            child: const RoomLobby()),
        Visibility(
            visible: state.status == RoomStatus.enterMeet,
            child: const AudioButton()),
      ]);
    });
  }
}

class RoomItem extends StatelessWidget {
  final RoomRenderItemModel item;

  const RoomItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: item.top,
        left: item.left,
        child: Image.asset(
          item.asset.source,
          scale: item.asset.scale,
        ));
  }
}
