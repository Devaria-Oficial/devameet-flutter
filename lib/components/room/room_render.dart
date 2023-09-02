

import 'package:flutter/material.dart';

class RoomRender extends StatelessWidget {
  const RoomRender({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 100,
          top: 50,
          child: Image.asset("assets/devameet/Chair/chair_02_right.png")
        ),
        Positioned(
          left: 0,
          top: 0,
          child: Image.asset("assets/devameet/Nature/nature_01.png")
        ),
        Positioned(
          left: 200,
          top: 50,
          child: Image.asset("assets/devameet/Avatar/avatar_01_left.png")
        ),
      ],
    );
  }

}