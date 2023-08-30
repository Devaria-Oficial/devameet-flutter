

import 'package:devameet_flutter/components/profile/input_profile.dart';
import 'package:flutter/material.dart';

class UserForm extends StatelessWidget {
  const UserForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(child: Column(
      children: [
        InputProfile(label: "Nome")
      ],
    ));
  }
}