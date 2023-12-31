import 'package:devameet_flutter/constants/color.dart';
import 'package:devameet_flutter/cubits/app/app_cubit.dart';
import 'package:devameet_flutter/cubits/login/login_cubit.dart';
import 'package:devameet_flutter/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../components/auth/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(create: (_) => sl<LoginCubit>() , child: LoginView()));
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.success) {
            context.read<AppCubit>().performLogin(state.auth!);
          }
        },
        builder: (context, state) => SingleChildScrollView(
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
                            onTap: () => context.go("/sign_up"),
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
