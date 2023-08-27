

part of 'app_cubit.dart';

enum AppStatus { initial, authenticated, unauthenticated }

class AppState extends Equatable {
  final AppStatus status;

  const AppState({required this.status});

  @override
  List<Object?> get props => [status];

  factory AppState.initial() {
    return const AppState(status: AppStatus.initial);
  }

  AppState copyWith({AppStatus? status}) {
    return AppState(status: status ?? this.status);
  }


}