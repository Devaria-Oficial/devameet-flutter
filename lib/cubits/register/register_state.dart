part of 'register_cubit.dart';

enum RegisterStatus { initial, submitting, success, error}

class RegisterState extends Equatable {
  final FormHandler form;
  final RegisterStatus status;

  const RegisterState({required this.form, required this.status});

  factory RegisterState.initial() {
    return RegisterState(form:
        FormHandler({
          "avatar": FormInput<String>(""),
          "name": FormInput<String>(""),
          "email": FormInput<String>(""),
          "password": FormInput<String>(""),
          "confirmPassword": FormInput<String>(""),
        })

        , status: RegisterStatus.initial);
  }

  @override
  List<Object?> get props => [status];

  RegisterState copyWith({FormHandler? form, RegisterStatus? status}) {
    return RegisterState(form: form ?? this.form, status: status ?? this.status);
  }
}