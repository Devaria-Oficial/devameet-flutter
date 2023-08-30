import 'package:devameet_flutter/constants/color.dart';
import 'package:devameet_flutter/cubits/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoundAvatar extends StatelessWidget {
  const RoundAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      return Container(
        height: height * 0.125,
        width: height * 0.125,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: DColors.white2,
            border: Border.all(color: DColors.primary3, width: 3),
            image:
                state.status == ProfileStatus.userLoaded && state.user != null
                    ? DecorationImage(
                        image: AssetImage(
                            "assets/devameet/Avatar/${state.user!.avatar}_front.png"),
                        scale: 0.78,
                        alignment: Alignment(0, 45))
                    : null),
      );
    });
  }
}
