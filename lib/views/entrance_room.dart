import 'package:devameet_flutter/components/room/user_section.dart';
import 'package:devameet_flutter/components/shared/button.dart';
import 'package:devameet_flutter/components/shared/header.dart';
import 'package:devameet_flutter/components/shared/input_field.dart';
import 'package:devameet_flutter/components/shared/menu.dart';
import 'package:devameet_flutter/constants/color.dart';
import 'package:devameet_flutter/cubits/profile/profile_cubit.dart';
import 'package:devameet_flutter/cubits/room/room_cubit.dart';
import 'package:devameet_flutter/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntranceRoomPage extends StatelessWidget {
  const EntranceRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: DColors.white,
      appBar: Header(
        height: height * 0.075,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => sl<ProfileCubit>()..loadUser(),
          ),
          BlocProvider(
            create: (_) => sl<RoomCubit>(),
          ),
        ],
        child: const EntranceRoomView(),
      ),
      bottomNavigationBar: const Menu(currentSelected: 1),
    );
  }
}

class EntranceRoomView extends StatelessWidget {
  const EntranceRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserSection(
          headerText: "Reunião",
        ),
        SingleChildScrollView(
          reverse: true,
          child: RoomForm(),
        )
      ],
    );
  }
}

class RoomForm extends StatelessWidget {
  const RoomForm({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<RoomCubit, RoomState>(builder: (context, state) {
      return Form(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.088888888888889, vertical: height * 0.0625),
          child: Column(
            children: [
              InputField(
                  hint: "Informe o link da reunião para entrar",
                  iconPath: "assets/icons/link.svg",
                  onChanged: (link) {}),
              SizedBox(height: height * 0.0625,),
              Button(
                text: "Entrar",
                onPressed: () {},
              )
            ],
          ),
        ),
      );
    });
  }
}
