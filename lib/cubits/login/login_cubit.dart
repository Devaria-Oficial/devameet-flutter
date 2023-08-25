import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_stream_handler/form_stream_handler.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  LoginCubit() : super(LoginState.initial());

  void changeEmail(String email) {
    print(email);
  }

  void changePassword(String password) {
    print(password);
  }

}