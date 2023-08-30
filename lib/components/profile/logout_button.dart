import 'package:devameet_flutter/constants/color.dart';
import 'package:devameet_flutter/cubits/app/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextButton.icon(
        onPressed: context.read<AppCubit>().performLogout,
        icon: SvgPicture.asset(
          "assets/icons/logout.svg",
        ),
        label: Text("Sair",
            style: TextStyle(
                color: DColors.primary3,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 2)));
  }
}
