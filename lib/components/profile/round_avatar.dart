import 'package:devameet_flutter/constants/color.dart';
import 'package:flutter/material.dart';

class RoundAvatar extends StatelessWidget {
  const RoundAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.125,
      width: height * 0.125,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: DColors.white2,
          border: Border.all(color: DColors.primary3, width: 3),
          image: DecorationImage(
              image: AssetImage("assets/devameet/Avatar/avatar_07_front.png"),
              scale: 0.78,
              alignment: Alignment(0, 45))),
    );
  }
}
