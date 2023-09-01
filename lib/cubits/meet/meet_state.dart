
part of 'meet_cubit.dart';

enum MeetStatus { initial, loading, success, error }

class MeetState extends Equatable {
  final MeetStatus status;
  final List<MeetModel> meets;

  const MeetState({required this.status, required this.meets});

  @override
  List<Object?> get props => [status, meets];

  factory MeetState.initial() {
    return const MeetState(status: MeetStatus.initial, meets: []);
  }

  MeetState copyWith({MeetStatus? status, List<MeetModel>? meets }) {
    return MeetState(status: status ?? this.status, meets: meets ?? this.meets);
  }

}