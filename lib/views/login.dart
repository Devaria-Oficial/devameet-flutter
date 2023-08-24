import 'package:devameet_flutter/components/shared/button.dart';
import 'package:devameet_flutter/components/shared/input_field.dart';
import 'package:devameet_flutter/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Column(children: [
      Container(
        margin: EdgeInsets.only(top: height * 0.15),
        child: SvgPicture.asset("assets/images/Logo.svg"),
      ),
      Container(
          margin: EdgeInsets.only(top: height * 0.12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
                child: Column(
              children: [
                InputField(
                    hint: "Email", iconPath: "assets/icons/envelope.svg"),
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
          )),
      Container(
          margin: EdgeInsets.only(top: height * 0.0375),
          child: Column(
            children: [
              Text("Não possui uma conta?"),
              GestureDetector(child: Text("Faça seu cadastro agora!"))
            ],
          )),
    ]));
  }
}
