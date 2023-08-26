import 'package:devameet_flutter/components/shared/select_avatar.dart';
import 'package:devameet_flutter/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fsp;

class ChoiceAvatar extends StatelessWidget {
  const ChoiceAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
        width: height * 0.1875,
        height: height * 0.1875,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: DColors.white,
          border: Border.all(color: DColors.primary3, width: 3),
          image: DecorationImage(
            image: fsp.Svg("assets/icons/empty_avatar.svg"),
            alignment: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                right: 0,
                child: SizedBox.fromSize(
                  size: Size(height * 0.0625, height * 0.0625),
                  child: ClipOval(
                      child: Material(
                    color: DColors.primary3,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        showDialog(context: context, builder: (context) => SelectAvatar());
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/edit.svg")
                        ]
                      )
                    ),
                  )),
                ))
          ],
        ));
  }
}
