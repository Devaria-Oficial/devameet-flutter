import 'package:devameet_flutter/components/profile/round_avatar.dart';
import 'package:devameet_flutter/components/shared/select_avatar.dart';
import 'package:devameet_flutter/constants/color.dart';
import 'package:flutter/material.dart';

class EditAvatar extends StatelessWidget {
  const EditAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        RoundAvatar(),
        SizedBox(height: height * 0.0125),
        TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => SelectAvatar(onSave: (avatar) {}));
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: Size.zero
            ),
            child: Text(
              "Alterar avatar",
              style: TextStyle(
                  color: DColors.primary3,
                  decoration: TextDecoration.underline,
                  fontSize: 12,
                  height: 2,
                  fontWeight: FontWeight.w500),
            ))
      ],
    );
  }
}
