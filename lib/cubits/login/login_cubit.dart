import 'package:devameet_flutter/errors/failures.dart';
import 'package:devameet_flutter/models/auth_model.dart';
import 'package:devameet_flutter/services/auth_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_stream_handler/form_stream_handler.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthApiService authApiService;

  LoginCubit({required this.authApiService}) : super(LoginState.initial());

  void changeEmail(String email) {
    state.form.setValue("email", email);
  }

  void changePassword(String password) {
    state.form.setValue("password", password);
  }

  void performLogin() async {

    bool isValid = state.form.validate();
    if(!isValid) return;

    emit(state.copyWith(status: LoginStatus.submitting));

    final email = state.form.getValue("email");
    final password = state.form.getValue("password");

    final failureOrAuth = await authApiService.login(email, password);

    failureOrAuth.fold((failure) {
      failure as AppFailure;
      emit(state.copyWith(errorMessage: failure.error, status: LoginStatus.error));
    }, (authModel) => emit(state.copyWith(status: LoginStatus.success, auth: authModel)));


  }

}