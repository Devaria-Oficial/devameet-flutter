import 'package:devameet_flutter/components/profile/round_avatar.dart';
import 'package:devameet_flutter/components/shared/select_avatar.dart';
import 'package:devameet_flutter/constants/color.dart';
import 'package:devameet_flutter/cubits/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditAvatar extends StatelessWidget {
  const EditAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            RoundAvatar(),
            SizedBox(height: height * 0.0125),
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => SelectAvatar(onSave: context.read<ProfileCubit>().changeAvatar ));
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minimumSize: Size.zero
                ),
                child: Text(
                  "Alterar avatar",
                  style: TextStyle(
                      color: DColors.primary3,
                      decoration: TextDecoration.underline,
                      fontSize: 12,
                      height: 2,
                      fontWeight: FontWeight.w500),
                ))
          ],
        );
      }
    );
  }
}
