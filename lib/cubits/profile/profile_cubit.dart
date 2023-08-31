import 'package:devameet_flutter/models/user_model.dart';
import 'package:devameet_flutter/services/user_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_stream_handler/form_stream_handler.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserApiService userApiService;

  ProfileCubit({required this.userApiService}) : super(ProfileState.initial());

  void loadUser() async {
    emit(state.copyWith(status: ProfileStatus.loadingUser));
    final failureOrUser = await userApiService.get();

    failureOrUser.fold((l) => emit(state.copyWith(status: ProfileStatus.error)),
        (user) {
      if (isClosed) return;
      emit(state.copyWith(status: ProfileStatus.userLoaded, user: user));
      state.form.setValue("name", user.name);
    });
  }

  void changeAvatar(avatar) =>
      emit(state.copyWith(user: state.user?.copyWith(avatar: avatar)));
  void changeName(name) => state.form.setValue("name", name);

  void performUpdate() async {
    bool isValid = state.form.validate();

    if (!isValid) return;

    final updatedUser = state.user?.copyWith(name: state.form.getValue("name"));

    final failureOrUpdated = await userApiService.update(updatedUser!);

    print(failureOrUpdated);

    failureOrUpdated.fold(
        (l) => emit(state.copyWith(status: ProfileStatus.error)),
        (r) => emit(state.copyWith(status: ProfileStatus.userUpdated)));
  }
}
