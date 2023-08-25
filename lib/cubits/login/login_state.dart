part of 'login_cubit.dart';

enum LoginStatus { initial, error, success, submitting}

class LoginState extends Equatable {
  final LoginStatus status;
  final FormHandler form;
  final String? errorMessage;
  const LoginState({required this.form, this.errorMessage, required this.status});

  @override
  List<Object?> get props => [status, errorMessage];

  factory LoginState.initial() {
    return LoginState(
        status: LoginStatus.initial,
        form: FormHandler({
      "email": FormInput<String>('',
          validator: Validator()
              .required("o e-mail deve ser informado")
              .email("Informe um e-mail valido!")),
      "password": FormInput<String>('',
          validator: Validator().required("A senha deve ser informada")),
    }));
  }

  LoginState copyWith({FormHandler? form, String? errorMessage, LoginStatus? status}) {
    return LoginState(
        status: status ?? this.status,
        form: form ?? this.form,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
