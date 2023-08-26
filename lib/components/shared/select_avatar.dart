import 'package:devameet_flutter/constants/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectAvatar extends StatelessWidget {
  const SelectAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Avatar",
            style: TextStyle(
                color: DColors.grey2,
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
          Text("Selecione seu avatar",
              style: TextStyle(
                  color: DColors.primary3,
                  fontSize: 16,
                  fontWeight: FontWeight.w700))
        ],
      ),
      content: Container(
        width: width,
        child: GridView.count(
            crossAxisSpacing: 7.79,
            mainAxisSpacing: 7.79,
            crossAxisCount: 3,
            children: List.generate(
                9,
                (index) => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all((Radius.circular(4))),
                        color: DColors.white2,
                        border: index == 4 ? Border.all(color: DColors.primary3, width: 2) : null
                    )))),
      ),
      actions: [],
    );
  }
}
