import 'package:devameet_flutter/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoomLobby extends StatelessWidget {
  const RoomLobby({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Positioned(
        child: Container(
      color: DColors.grey4.withOpacity(0.75),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/door.svg",
              color: DColors.white,
              width: height * 0.10625,
            ),
            SizedBox(
              height: height * 0.025,
            ),
            TextButton(onPressed: () {},
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                ),
                padding: EdgeInsets.symmetric(vertical: height * 0.0171875, horizontal: 1.8 * (height * 0.0171875) ),
                side: BorderSide(width: 2, color: DColors.white,)
              ), child: Text("Entrar na sala", style: TextStyle(
              color: DColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.2
            ),),

            )
          ],
        ),
      ),
    ));
  }
}
