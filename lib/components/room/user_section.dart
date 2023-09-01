import 'package:devameet_flutter/constants/color.dart';
import 'package:devameet_flutter/cubits/profile/profile_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSection extends StatelessWidget {
  const UserSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {

      if (state.status == ProfileStatus.loadingUser) {
        return Container(
            child: LinearProgressIndicator(
          backgroundColor: DColors.primary3,
          color: DColors.secondary2,
        ));
      }

      return Container(
        width: width,
        padding: EdgeInsets.all(height * 0.025),
        decoration: BoxDecoration(
          color: DColors.white,
          border: Border(bottom: BorderSide(color: DColors.grey1, width: 0.5))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Minhas reuniões",
              style: TextStyle(
                  color: DColors.grey2,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
            Text("Olá, ${state.user?.name}", style: TextStyle(
              color: DColors.primary3,
              fontSize: 16,
              fontWeight: FontWeight.w700
            ),)
          ],
        ),
      );
    });
  }
}
