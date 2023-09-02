import 'package:devameet_flutter/services/room_ws_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'room_ws_state.dart';

class RoomWsCubit extends Cubit<RoomWsState> {
  final RoomWsService roomWsService;

  RoomWsCubit({
    required this.roomWsService
  }) : super(RoomWsState.initial());

  @override
  Future<void> close() async {
    roomWsService.disconnect();
    return super.close();
  }

  void start() {
    roomWsService.connect();
  }

}