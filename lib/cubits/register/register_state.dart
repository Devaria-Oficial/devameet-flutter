part of 'register_cubit.dart';

enum RegisterStatus { initial, submitting, success, error }

class RegisterState extends Equatable {
  final FormHandler form;
  final RegisterStatus status;
  final String? errorMessage;

  const RegisterState(
      {required this.form, required this.status, this.errorMessage});

  factory RegisterState.initial() {
    return RegisterState(
        form: FormHandler({
          "avatar": FormInput<String>("",
              validator: Validator().required(("Escolha um avatar"))),
          "name": FormInput<String>("",
              validator: Validator().required("O nome deve ser informado")),
          "email": FormInput<String>("",
              validator: Validator()
                  .required("O e-mail deve ser informado")
                  .email("Informe um e-mail válido")),
          "password": FormInput<String>("",
              validator: Validator().required("A senha deve ser informada")),
          "confirmPassword": FormInput<String>("",
              validator: Validator()
                  .required("A confirmação da senha deve ser informada")),
        }),
        status: RegisterStatus.initial,
        errorMessage: null);
  }

  @override
  List<Object?> get props => [status];

  RegisterState copyWith(
      {FormHandler? form, RegisterStatus? status, String? errorMessage}) {
    return RegisterState(
        form: form ?? this.form,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
