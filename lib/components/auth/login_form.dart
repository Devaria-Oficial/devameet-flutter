import 'package:devameet_flutter/components/shared/button.dart';
import 'package:devameet_flutter/components/shared/input_field.dart';
import 'package:devameet_flutter/constants/color.dart';
import 'package:devameet_flutter/cubits/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Form(
            child: Column(
          children: [
            InputField(
              hint: "Email",
              iconPath: "assets/icons/envelope.svg",
              onChanged: (email) => context.read<LoginCubit>().changeEmail(email),
              stream: state.form.getStream("email"),
              initialValue: state.form.getValue("email"),
            ),
            SizedBox(height: height * 0.0375),
            InputField(
                hint: "Senha",
                inputType: InputType.password,
                iconPath: "assets/icons/key.svg",
                onChanged: (password) => context.read<LoginCubit>().changePassword(password),
                stream: state.form.getStream("password"),
                initialValue: state.form.getValue("password")),
            SizedBox(height: height * 0.03 ),
            Visibility(visible: state.status == LoginStatus.error, child: Text(state!.errorMessage ?? "", style: TextStyle(color: DColors.redError),)),
            Container(
              margin: EdgeInsets.only(top: height * 0.0625),
              child: Button(
                text: "Login",
                onPressed: context.read<LoginCubit>().performLogin,
              ),
            )
          ],
        )),
      );
    });
  }
}
