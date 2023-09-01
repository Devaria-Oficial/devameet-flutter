import 'package:devameet_flutter/services/meet_api_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'meet_state.dart';


class MeetCubit extends Cubit<MeetState> {
  final MeetApiService meetApiService;

  MeetCubit({required this.meetApiService}) : super(MeetState.initial());

  void loadMeets() async {

    meetApiService.list();
  }
}
