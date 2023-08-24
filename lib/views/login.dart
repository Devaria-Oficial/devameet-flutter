
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});



  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;


    return Scaffold(
      body: Column(
      children: [
          Container(
            margin: EdgeInsets.only(top: height * 0.15),
            child: SvgPicture.asset("assets/images/Logo.svg"),
          ),

          Container(
            margin: EdgeInsets.only(top: height * 0.12),
            child: Form(
              child: Column(
                children: [
                  TextFormField(),
                  TextFormField(),
                  Container(
                    margin: EdgeInsets.only(top: height * 0.0625),
                    child: ElevatedButton(onPressed: () => {}, child: Text("Login")),
                  )

                ],
              )
            )
          ),

          Container(
            margin: EdgeInsets.only(top: height * 0.0375),
            child: Column(
              children: [
                Text("Não possui uma conta?"),
                GestureDetector(
                    child: Text("Faça seu cadastro agora!")
                )
              ],
            )
          ),

        ]
    ));
  }
}