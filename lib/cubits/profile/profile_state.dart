part of 'profile_cubit.dart';

enum ProfileStatus { initial }

class ProfileState extends Equatable {
  final ProfileStatus status;

  const ProfileState({required this.status});

  @override
  List<Object?> get props => [status];

  factory ProfileState.initial() {
    return ProfileState(status: ProfileStatus.initial);
  }

  ProfileState copyWith({ProfileStatus? status}) {
    return ProfileState(status: status ?? this.status);
  }
}