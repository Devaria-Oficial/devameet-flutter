

import 'package:devameet_flutter/components/profile/input_profile.dart';
import 'package:devameet_flutter/cubits/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserForm extends StatelessWidget {
  const UserForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Form(child: Column(
          children: [
            InputProfile(label: "Nome", stream: state.form.getStream("name"),)
          ],
        ));
      }
    );
  }
}