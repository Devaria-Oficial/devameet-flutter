

import 'package:equatable/equatable.dart';
import 'package:form_stream_handler/form_stream_handler.dart';

class LoginState extends Equatable {

  final FormHandler form;

  const LoginState({
    required this.form
  });

  @override
  List<Object?> get props => [];

  factory LoginState.initial() {
    return LoginState(
      form: FormHandler(
        {
          "email": FormInput<String>(''),
          "password": FormInput<String>(''),
        }
      )

    );
  }

  LoginState copyWith({FormHandler? form}) {
    return LoginState(form: form ?? this.form);
  }
}