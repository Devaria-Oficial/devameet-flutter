part of 'profile_cubit.dart';

enum ProfileStatus { initial, error, loadingUser, userLoaded }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserModel? user;
  final FormHandler form;

  const ProfileState({required this.status, required this.user, required this.form});

  @override
  List<Object?> get props => [status];

  factory ProfileState.initial() {
    return ProfileState(status: ProfileStatus.initial, user: null, form: FormHandler({
      "name": FormInput<String>('', validator: Validator().required("O nome não pode ser vazio."))
    }));
  }

  ProfileState copyWith({ProfileStatus? status, UserModel? user, FormHandler? form}) {
    return ProfileState(status: status ?? this.status, user: user ?? this.user, form: form ?? this.form);
  }
}
