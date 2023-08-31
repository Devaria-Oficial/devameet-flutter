

import 'package:devameet_flutter/components/profile/edit_avatar.dart';
import 'package:devameet_flutter/components/profile/logout_button.dart';
import 'package:devameet_flutter/components/profile/profile_action.dart';
import 'package:devameet_flutter/components/profile/user_form.dart';
import 'package:devameet_flutter/components/shared/menu.dart';
import 'package:devameet_flutter/constants/color.dart';
import 'package:devameet_flutter/cubits/app/app_cubit.dart';
import 'package:devameet_flutter/cubits/profile/profile_cubit.dart';
import 'package:devameet_flutter/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (_) => sl<ProfileCubit>()..loadUser(),
          child: ProfileView()),
      bottomNavigationBar: const Menu(currentSelected: 2,),
    );
  }

}

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;


    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {

        if(state.status == ProfileStatus.userUpdated) {
          context.go("/");
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: DColors.grey1, width: 1)
                )
              ),
              padding: EdgeInsets.only(
                top: height * 0.05,
                left: height * 0.025,
                right: height * 0.025,
                bottom: height * 0.01875
              ),
              child: ProfileAction(),
            ),
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: height * 0.025),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: DColors.grey1, width: 1)
                  )
              ),
              child: const UserForm(),
            ),
            const Spacer(),
            Container(
              child: const LogoutButton()
            ),
          ],
        );
      }
    );
  }
  
}