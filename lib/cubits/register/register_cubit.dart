

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_stream_handler/form_stream_handler.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {

  RegisterCubit() : super(RegisterState.initial());

  void changeAvatar(String avatar) => state.form.setValue("avatar", avatar);
  void changeName(String name) => state.form.setValue("name", name);
  void changeEmail(String email) => state.form.setValue("email", email);
  void changePassword(String password) => state.form.setValue("password", password);
  void changeConfirmPassword(String confirmPassword) => state.form.setValue("confirmPassword", confirmPassword);

  void performRegister() {
    print(state.form.getValue("name"));
    print(state.form.getValue("email"));
    print(state.form.getValue("password"));
    print(state.form.getValue("confirmPassword"));
  }
}