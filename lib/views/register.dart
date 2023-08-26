

import 'package:devameet_flutter/components/auth/register_form.dart';
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
    return Column(
      children: [
        // TODO: Choice Avatar
        Container(),

        Container(
          child: RegisterForm()
        ),
        Container(
          child: Column(
            children: [
              Text("Já possui uma conta?"),
              GestureDetector(
                onTap: () => context.go("/sign_in"),
                child: Text("Faça seu login agora!"),
              )
            ],
          ),
        )
      ],
    );
  }

}