
import 'package:devameet_flutter/services/user_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserApiService userApiService;

  ProfileCubit({required this.userApiService}) : super(ProfileState.initial());

  void loadUser() async {
    userApiService.get();
  }

}