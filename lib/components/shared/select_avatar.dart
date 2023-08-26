

import 'package:devameet_flutter/constants/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectAvatar extends StatelessWidget {
  const SelectAvatar({super.key});

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Avatar", style: TextStyle(color: DColors.grey2, fontSize: 12, fontWeight: FontWeight.w600),),
          Text("Selecione seu avatar", style: TextStyle(color: DColors.primary3, fontSize: 16, fontWeight: FontWeight.w700))
        ],
      ),
      content: Container(),
      actions: [],
    );
  }

}