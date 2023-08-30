

import 'package:devameet_flutter/components/profile/edit_avatar.dart';
import 'package:devameet_flutter/constants/color.dart';
import 'package:devameet_flutter/cubits/app/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ProfileView()
      )
    );
  }

}

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;


    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(),
        Container(
          width: width,
          padding: EdgeInsets.symmetric(vertical: height * 0.025),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: DColors.grey1, width: 1)
            )
          ),
          child: EditAvatar(),
        ),
        Container(),
        Spacer(),
        Container(
          child: ElevatedButton(
            onPressed: context.read<AppCubit>().performLogout,
            child: Text("Sair"),
          ),
        ),
      ],
    );
  }
  
}