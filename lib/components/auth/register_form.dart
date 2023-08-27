import 'package:devameet_flutter/components/shared/button.dart';
import 'package:devameet_flutter/components/shared/input_field.dart';
import 'package:devameet_flutter/constants/color.dart';
import 'package:devameet_flutter/cubits/register/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;

    // TODO: implement build
    return BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
      return Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.088),
          child: Column(
            children: [
              InputField(
                  hint: "Nome Completo",
                  iconPath: "assets/icons/user.svg",
                  onChanged: (name) =>
                      context.read<RegisterCubit>().changeName(name),
                  stream: state.form.getStream("name")),
              SizedBox(height: height * 0.0375),
              InputField(
                  hint: "E-mail",
                  iconPath: "assets/icons/envelope.svg",
                  onChanged: (email) =>
                      context.read<RegisterCubit>().changeEmail(email),
                  stream: state.form.getStream("email")),
              SizedBox(height: height * 0.0375),
              InputField(
                  hint: "Senha",
                  inputType: InputType.password,
                  iconPath: "assets/icons/key.svg",
                  onChanged: (password) =>
                      context.read<RegisterCubit>().changePassword(password),
                  stream: state.form.getStream("password")),
              SizedBox(height: height * 0.0375),
              InputField(
                  hint: "Confirmar Senha",
                  inputType: InputType.password,
                  iconPath: "assets/icons/key.svg",
                  onChanged: (confirmPassword) => context
                      .read<RegisterCubit>()
                      .changeConfirmPassword(confirmPassword),
                  stream: state.form.getStream("confirmPassword")),
              SizedBox(height: height * 0.0625),
              Visibility(
                  visible: state.status == RegisterStatus.error,
                  child: Container(
                    margin: EdgeInsets.only(bottom: height * 0.03),
                      child: Text(
                    state!.errorMessage ?? "",
                    style: TextStyle(color: DColors.redError),
                  ))),
              Container(
                  child: Button(
                text: "Cadastrar",
                onPressed: context.read<RegisterCubit>().performRegister,
              ))
            ],
          ),
        ),
      );
    });
  }
}
