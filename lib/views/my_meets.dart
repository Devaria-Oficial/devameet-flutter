
import 'package:devameet_flutter/components/room/meets_section.dart';
import 'package:devameet_flutter/components/room/user_section.dart';
import 'package:devameet_flutter/components/shared/header.dart';
import 'package:devameet_flutter/components/shared/menu.dart';
import 'package:devameet_flutter/cubits/meet/meet_cubit.dart';
import 'package:devameet_flutter/cubits/profile/profile_cubit.dart';
import 'package:devameet_flutter/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyMeetsPage extends StatelessWidget {
  const MyMeetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: Header(height: height * 0.075,),
      body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<ProfileCubit>()..loadUser(),),
            BlocProvider(create: (_) => sl<MeetCubit>()..loadMeets(), lazy: false,)
          ],
          child: const MyMeetsView()),
      bottomNavigationBar: const Menu(currentSelected: 0),
    );
  }

}

class MyMeetsView extends StatelessWidget {
  const MyMeetsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [UserSection(), Expanded(child: MeetsSection())]
    );
  }
  
}