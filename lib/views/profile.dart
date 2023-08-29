

import 'package:devameet_flutter/components/profile/edit_avatar.dart';
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
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(),
        Container(
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