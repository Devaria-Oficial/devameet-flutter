

import 'package:devameet_flutter/errors/failures.dart';
import 'package:devameet_flutter/services/auth_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_stream_handler/form_stream_handler.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthApiService authApiService;
  RegisterCubit({required this.authApiService}) : super(RegisterState.initial());

  void changeAvatar(String avatar) => state.form.setValue("avatar", avatar);
  void changeName(String name) => state.form.setValue("name", name);
  void changeEmail(String email) => state.form.setValue("email", email);
  void changePassword(String password) => state.form.setValue("password", password);
  void changeConfirmPassword(String confirmPassword) => state.form.setValue("confirmPassword", confirmPassword);

  void performRegister() async {
    bool isValid = state.form.validate();

    if(!isValid) return;

    final password = state.form.getValue("password");
    final confirmPassword = state.form.getValue("confirmPassword");
    final name = state.form.getValue("name");
    final email = state.form.getValue("email");
    final avatar = state.form.getValue("avatar");

    if (password != confirmPassword) {
      final error = "A confirmação de senha deve ser igual a senha";
      state.form.setError("confirmPassword", error);
      return;
    }

    final failureOrSuccess = await authApiService.register(email: email, password: password, name: name, avatar: avatar);

    failureOrSuccess.fold((failure) {
      failure as AppFailure;
      emit(state.copyWith(status: RegisterStatus.error, errorMessage: failure.error));
    }
    , (r) => emit(state.copyWith(status: RegisterStatus.success)));

  }
}