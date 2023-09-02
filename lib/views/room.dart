
import 'package:devameet_flutter/components/room/meet_detail.dart';
import 'package:devameet_flutter/components/room/not_found_room.dart';
import 'package:devameet_flutter/components/room/room_render.dart';
import 'package:devameet_flutter/components/shared/header.dart';
import 'package:devameet_flutter/components/shared/menu.dart';
import 'package:devameet_flutter/constants/color.dart';
import 'package:devameet_flutter/cubits/profile/profile_cubit.dart';
import 'package:devameet_flutter/cubits/room/room_cubit.dart';
import 'package:devameet_flutter/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fsp;

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
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<RoomCubit, RoomState>(
      builder: (context, state) {
        if (state.status == RoomStatus.loading) {
          return Center(child: CircularProgressIndicator(
            backgroundColor: DColors.primary3,
            color: DColors.secondary2,
          ));
        }

        return Container(
          height: height,
          decoration: BoxDecoration(
            color: DColors.primary3.withOpacity(0.05),
            image: const DecorationImage(image: fsp.Svg("assets/images/texture.svg"), fit: BoxFit.fitWidth)
          ),
          child: const RoomContent()
        );
      }
    );
  }

}

class RoomContent extends StatelessWidget {
  const RoomContent({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;


    return BlocBuilder<RoomCubit, RoomState>(builder: (context, state) {

      if (state.status == RoomStatus.notFound) {
        return const NotFoundRoom();
      }

      return Column(
        children: [
          MeetDetail(),
          SizedBox(
            width: width,
            height: width,
            child: RoomRender(),
          )
        ],
      );

    });
  }

}