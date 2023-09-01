import 'package:devameet_flutter/models/meet_model.dart';
import 'package:devameet_flutter/services/meet_api_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'meet_state.dart';

class MeetCubit extends Cubit<MeetState> {
  final MeetApiService meetApiService;

  MeetCubit({required this.meetApiService}) : super(MeetState.initial());

  void loadMeets() async {
    emit(state.copyWith(status: MeetStatus.loading));

    final failureOrMeets = await meetApiService.list();

    failureOrMeets.fold(
        (l) => emit(state.copyWith(status: MeetStatus.error)),
        (meets) {
          if(isClosed) return;
          print(meets);
          emit(state.copyWith(status: MeetStatus.success, meets: meets));

        });
  }

  void performDelete(MeetModel meet) async {
    await meetApiService.delete(meet);
    loadMeets();
  }
}
