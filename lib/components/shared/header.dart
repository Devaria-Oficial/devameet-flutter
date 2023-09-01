

import 'package:devameet_flutter/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget implements PreferredSize {
  final double height;
  const Header({super.key, required this.height});

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;

    return AppBar(
      shape: Border(
        bottom: BorderSide(
          color: DColors.grey1,
          width: 0.5
        )
      ),
      toolbarHeight: 100,
      title: SvgPicture.asset("assets/images/Logo.svg", height: height * 0.0375,),
      backgroundColor: DColors.white,
      centerTitle: true,
      elevation: 0,
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size.fromHeight(this.height);

}