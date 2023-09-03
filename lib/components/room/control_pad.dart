import 'package:devameet_flutter/constants/color.dart';
import 'package:devameet_flutter/cubits/room_ws/room_ws_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ControlPad extends StatelessWidget {
  const ControlPad({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Wrap(
          children: [
            SizedBox(
              width: width * 0.22222222222222,
              height: height * 0.0625,
              child: const ControlButton(direction: Direction.up),
            )
          ],
        ),
        SizedBox(height: height * 0.0078125),
        Wrap(
          spacing: height * 0.0078125,
          children: [
            SizedBox(
              width: width * 0.22222222222222,
              height: height * 0.0625,
              child: const ControlButton(direction: Direction.left),
            ),
            SizedBox(
              width: width * 0.22222222222222,
              height: height * 0.0625,
              child: const ControlButton(direction: Direction.down),
            ),
            SizedBox(
              width: width * 0.22222222222222,
              height: height * 0.0625,
              child: const ControlButton(direction: Direction.right),
            )
          ],
        )
      ],
    );

  }

}

class ControlButton extends StatelessWidget {
  final Direction direction;

  const ControlButton({super.key, required this.direction});

  static const icons = {
    Direction.up: "assets/icons/chevron-up.svg",
    Direction.down: "assets/icons/chevron-down.svg",
    Direction.left: "assets/icons/chevron-left.svg",
    Direction.right: "assets/icons/chevron-right.svg",
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => context.read<RoomWsCubit>().startMove(direction),
      onTapCancel:() => context.read<RoomWsCubit>().stopMove(),
      child: ElevatedButton(onPressed: () {},
          style: ButtonStyle(
            elevation: togglePropertiesOnPress(2, 0),
            backgroundColor: togglePropertiesOnPress(DColors.primary3, DColors.primary3.withOpacity(0.25))
          ),
          child:
        SvgPicture.asset(icons[direction]!, color: DColors.white,)
      ),
    );
  }

}

MaterialStateProperty<T> togglePropertiesOnPress<T>(T original, T onPress) {
  
  togglePropertie(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return onPress;
    }
    return original;
  }
  
  
  return MaterialStateProperty.resolveWith(togglePropertie);
  
}