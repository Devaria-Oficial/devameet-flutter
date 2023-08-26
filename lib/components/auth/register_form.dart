import 'package:devameet_flutter/components/shared/button.dart';
import 'package:devameet_flutter/components/shared/input_field.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;

    // TODO: implement build
    return Form(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.088),
        child: Column(
          children: [
            InputField(
              hint: "Nome Completo",
              iconPath: "assets/icons/user.svg",
              onChanged: (name) {},
            ),
            SizedBox(height: height * 0.0375),
            InputField(
              hint: "E-mail",
              iconPath: "assets/icons/envelope.svg",
              onChanged: (name) {},
            ),
            SizedBox(height: height * 0.0375),
            InputField(
              hint: "Senha",
              iconPath: "assets/icons/key.svg",
              onChanged: (name) {},
            ),
            SizedBox(height: height * 0.0375),
            InputField(
              hint: "Confirmar Senha",
              iconPath: "assets/icons/key.svg",
              onChanged: (name) {},
            ),
            SizedBox(height: height * 0.0625),
            Container(
              child: Button(
                text: "Cadastrar",
                onPressed: () => {},
              )
            )
          ],
        ),
      ),
    );
  }

}