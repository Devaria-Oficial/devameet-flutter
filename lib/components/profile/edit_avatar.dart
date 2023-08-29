

import 'package:devameet_flutter/components/profile/round_avatar.dart';
import 'package:devameet_flutter/components/shared/select_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditAvatar extends StatelessWidget {
  const EditAvatar({super.key});

  @override
  Widget build(BuildContext context) {
   return Column(
     children: [
       RoundAvatar(),
       TextButton(onPressed: (){
         showDialog(context: context, builder: (context) => SelectAvatar(onSave: (avatar) {} ));
       } , child: Text("Alterar avatar"))
     ],
   );
  }

}