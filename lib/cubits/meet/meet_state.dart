
part of 'meet_cubit.dart';

enum MeetStatus { initial }

class MeetState extends Equatable {
  final MeetStatus status;

  const MeetState({required this.status});

  @override
  List<Object?> get props => [status];

  factory MeetState.initial() {
    return const MeetState(status: MeetStatus.initial);
  }

  MeetState copyWith({MeetStatus? status}) {
    return MeetState(status: status ?? this.status);
  }

}