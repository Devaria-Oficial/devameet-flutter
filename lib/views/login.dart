import 'package:devameet_flutter/components/shared/button.dart';
import 'package:devameet_flutter/components/shared/input_field.dart';
import 'package:devameet_flutter/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../components/auth/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
      reverse: true,
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(top: height * 0.15),
          child: SvgPicture.asset("assets/images/Logo.svg"),
        ),
        Container(
            margin: EdgeInsets.only(top: height * 0.12),
            child: const LoginForm()),
        Container(
            margin: EdgeInsets.only(top: height * 0.0375),
            child: Column(
              children: [
                Text(
                  "Não possui uma conta?",
                  style: TextStyle(
                      color: DColors.grey3,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                    child: Text("Faça seu cadastro agora!",
                        style: TextStyle(
                            color: DColors.primary3,
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            decorationThickness: 1.5)))
              ],
            )),
      ]),
    ));
  }
}
