import 'package:devameet_flutter/components/shared/button.dart';
import 'package:devameet_flutter/components/shared/input_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Form(
          child: Column(
        children: [
          InputField(hint: "Email", iconPath: "assets/icons/envelope.svg"),
          SizedBox(height: height * 0.0375),
          InputField(hint: "Senha", iconPath: "assets/icons/key.svg"),
          Container(
            margin: EdgeInsets.only(top: height * 0.0625),
            child: Button(
              text: "Login",
            ),
          )
        ],
      )),
    );
  }
}
