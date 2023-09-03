

import 'package:devameet_flutter/constants/color.dart';
import 'package:devameet_flutter/cubits/room/room_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MeetDetail extends StatelessWidget {
  const MeetDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<RoomCubit, RoomState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: height * 0.025, vertical: height * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Reunião ", style: TextStyle(color: DColors.grey3, fontSize: 12, fontWeight: FontWeight.w600),),
                  Text(state.room!.link, style: TextStyle(color: DColors.grey3, fontSize: 12, fontWeight: FontWeight.w400)),
                  SizedBox(width: width * 0.011111111111111),
                  InkWell(
                    splashColor: DColors.grey1,
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: state.room!.link)).then((_) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Link copiado!")));
                      });
                    },
                    child: SvgPicture.asset("assets/icons/copy.svg", color: DColors.primary1,),
                  )
                ],
              ),
              Text(state.room!.name, style: TextStyle(color: DColors.primary1, fontSize: 16, fontWeight: FontWeight.w700),)
            ],
          )
        );
      }
    );
  }

}