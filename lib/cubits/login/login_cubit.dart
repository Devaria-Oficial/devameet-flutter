import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_stream_handler/form_stream_handler.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  LoginCubit() : super(LoginState.initial());

  void changeEmail(String email) {
    state.form.setValue("email", email);
  }

  void changePassword(String password) {
    state.form.setValue("password", password);
  }

  void performLogin() {

    bool isValid = state.form.validate();

    print(isValid);


  }

}