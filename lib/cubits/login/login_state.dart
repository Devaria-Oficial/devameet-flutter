part of 'login_cubit.dart';

class LoginState extends Equatable {
  final FormHandler form;
  const LoginState({required this.form});

  @override
  List<Object?> get props => [];

  factory LoginState.initial() {
    return LoginState(
        form: FormHandler({
      "email": FormInput<String>('',
          validator: Validator()
              .required("o e-mail deve ser informado")
              .email("Informe um e-mail valido!")),
      "password": FormInput<String>('',
          validator: Validator().required("A senha deve ser informada")),
    }));
  }

  LoginState copyWith({FormHandler? form}) {
    return LoginState(form: form ?? this.form);
  }
}
