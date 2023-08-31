import 'package:devameet_flutter/constants/color.dart';
import 'package:devameet_flutter/cubits/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileAction extends StatelessWidget {
  const ProfileAction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () => context.go("/"),
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size.zero),
                child: Text("Cancelar",
                    style: TextStyle(
                        color: DColors.grey3,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 2,
                        letterSpacing: 0.12))),
            Text(
              "Editar perfil",
              style: TextStyle(
                  color: DColors.grey4,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  height: 1.5,
                  letterSpacing: 0.16),
            ),
            TextButton(
                onPressed: context.read<ProfileCubit>().performUpdate,
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size.zero),
                child: Text("Concluir", style: TextStyle(
                  color: DColors.primary3,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  height: 2,
                  letterSpacing: 0.12
                ),))
          ],
        );
      }
    );
  }
}
