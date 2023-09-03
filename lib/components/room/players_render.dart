import 'package:devameet_flutter/constants/color.dart';
import 'package:devameet_flutter/cubits/room_ws/room_ws_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayersRender extends StatelessWidget {
  const PlayersRender({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomWsCubit, RoomWsState>(builder: (context, state) {
      return Stack(
        children: state.playerRenderItems
            .map<Widget>((playerRender) => Positioned(
                top: playerRender.roomRenderItem.top,
                left: playerRender.roomRenderItem.left,
                child: Player(
                  name: playerRender.player.name,
                  asset: playerRender.roomRenderItem.asset.source,
                )))
            .toList(),
      );
    });
  }
}

class Player extends StatelessWidget {
  final String name;
  final String asset;

  const Player({super.key, required this.name, required this.asset});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: DColors.grey4.withOpacity(0.75),
            border: Border.all(color: DColors.primary4, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(20))
          ),
          padding: EdgeInsets.symmetric(horizontal: height * 0.0125, vertical: height * 0.0046875),
          child: Text(name, style: TextStyle(
            color: DColors.primary4,
            fontSize: 8,
            fontWeight: FontWeight.w500
          ),)
        ),
        SizedBox(height: height * 0.00625),
        Image.asset(
          asset,
          scale: 1.2,
        )
      ],
    );
  }
}
