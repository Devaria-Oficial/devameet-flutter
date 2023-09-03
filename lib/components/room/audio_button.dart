import 'package:devameet_flutter/cubits/room_ws/room_ws_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AudioButton extends StatelessWidget {
  const AudioButton({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<RoomWsCubit, RoomWsState>(
      builder: (context, state) {
        return Positioned(
            bottom: 0,
            right: 0,
            child: ElevatedButton(
                onPressed: context.read<RoomWsCubit>().toggleAudio,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(), backgroundColor: Colors.transparent
                ),
                child: state.muted
                    ? SvgPicture.asset("assets/icons/microphone-off.svg")
                    : SvgPicture.asset("assets/icons/microphone-on.svg")));
      },
    );
  }
}
