import 'package:devameet_flutter/components/shared/input_field.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      child: Column(
        children: [
          InputField(
            hint: "Nome Completo",
            iconPath: "assets/icons/user.svg",
            onChanged: (name) {},
          ),
          InputField(
            hint: "E-mail",
            iconPath: "assets/icons/envelope.svg",
            onChanged: (name) {},
          ),
          InputField(
            hint: "Senha",
            iconPath: "assets/icons/key.svg",
            onChanged: (name) {},
          ),
          InputField(
            hint: "Confirmar Senha",
            iconPath: "assets/icons/key.svg",
            onChanged: (name) {},
          ),
        ],
      ),
    );
  }

}