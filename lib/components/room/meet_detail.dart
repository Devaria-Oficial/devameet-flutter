

import 'package:devameet_flutter/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MeetDetail extends StatelessWidget {
  const MeetDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(height * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Reunião ", style: TextStyle(color: DColors.grey3, fontSize: 12, fontWeight: FontWeight.w600),),
              Text("zxc-f31-das", style: TextStyle(color: DColors.grey3, fontSize: 12, fontWeight: FontWeight.w400)),
              SizedBox(width: width * 0.011111111111111),
              InkWell(
                splashColor: DColors.grey1,
                onTap: () {},
                child: SvgPicture.asset("assets/icons/copy.svg", color: DColors.primary1,),
              )
            ],
          ),
          Text("Reuniao xpto foo baar", style: TextStyle(color: DColors.primary1, fontSize: 16, fontWeight: FontWeight.w700),)
        ],
      )
    );
  }

}