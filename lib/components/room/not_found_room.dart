import 'package:devameet_flutter/constants/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class NotFoundRoom extends StatelessWidget {
  const NotFoundRoom({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: width,
      margin: EdgeInsets.only(top: height * 0.1109375, bottom: height * 0.1578125) ,
      decoration: BoxDecoration(
        color: DColors.white,
        boxShadow: const[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.14),
            blurRadius: 1.0,
            offset: Offset(0, 1.0)
          ),
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.12),
              blurRadius: 1.0,
              offset: Offset(0, 2.0)
          ),
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              blurRadius: 3.0,
              offset: Offset(0, 1.0)
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/empty.svg"),
          Text("Reunião não encontrada :/", style: TextStyle(
            color: DColors.grey2,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 2.85,
            letterSpacing: 0.14
          ),)
        ],
      )
    );
  }
  
}