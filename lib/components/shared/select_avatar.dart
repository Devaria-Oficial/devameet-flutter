import 'package:devameet_flutter/components/shared/button.dart';
import 'package:devameet_flutter/constants/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectAvatar extends StatelessWidget {
  const SelectAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
                  fontWeight: FontWeight.w700)),
          SizedBox(height: height * 0.025),
          const Divider()
        ],
      ),
      content: Container(
        width: width,
        child: GridView.count(
            crossAxisSpacing: width * 0.021944444444444,
            mainAxisSpacing: height * 0.01234375,
            crossAxisCount: 3,
            children: List.generate(
                9,
                (index) => InkWell(
                  onTap: () {},
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all((Radius.circular(4))),
                          color: DColors.white2,
                          border: index == 4 ? Border.all(color: DColors.primary3, width: 2) : null
                      ),
                      child: Image.asset("assets/devameet/Avatar/avatar_0${index+1}_front.png", fit: BoxFit.contain,),

                  ),
                ))),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: width * 0.22,
                child: Button(text: "Voltar", onPressed: () {}, isInverted: true,)),
            SizedBox(
              width: width * 0.01,
            ),
            SizedBox(
                width: width * 0.41666666666667,
                child: Button(text: "Salvar", onPressed: () {},)),
          ],
        )
      ],
    );
  }
}
