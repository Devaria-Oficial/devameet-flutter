
import 'package:devameet_flutter/components/shared/header.dart';
import 'package:devameet_flutter/components/shared/menu.dart';
import 'package:devameet_flutter/cubits/profile/profile_cubit.dart';
import 'package:devameet_flutter/cubits/room/room_cubit.dart';
import 'package:devameet_flutter/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomPage extends StatelessWidget {
  final String link;
  const RoomPage({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: Header(
        height: height * 0.075,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => sl<ProfileCubit>()..loadUser(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => sl<RoomCubit>()..loadRoom(link),
            lazy: false,
          ),
          ],
        child: const RoomView(),
      ),
      bottomNavigationBar: const Menu(currentSelected: 1),
    );
  }
  
}

class RoomView extends StatelessWidget {
  const RoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

}