

import 'package:devameet_flutter/components/auth/choice_avatar.dart';
import 'package:devameet_flutter/components/auth/register_form.dart';
import 'package:devameet_flutter/constants/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const RegisterView()
    );
  }

}

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: height * 0.0921875),
          child: const ChoiceAvatar(),
        ),
        Container(
          margin: EdgeInsets.only(top: height * 0.075),
          child: RegisterForm()
        ),
        Container(
          margin: EdgeInsets.only(top: height * 0.0375),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Já possui uma conta?", style: TextStyle(color: DColors.grey3, fontSize: 14, fontWeight: FontWeight.w400),),
              GestureDetector(
                onTap: () => context.go("/sign_in"),
                child: Text("Faça seu login agora!", style: TextStyle(
                  color: DColors.primary3,
                  decoration: TextDecoration.underline,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                  decorationThickness: 1.5
                ),),
              )
            ],
          ),
        )
      ],
    );
  }

}