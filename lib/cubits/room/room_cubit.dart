
import 'package:devameet_flutter/services/room_api_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_stream_handler/form_stream_handler.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  final RoomApiService roomApiService;

  RoomCubit({required this.roomApiService}) : super(RoomState.initial());

  void changeLink(link) => state.form.setValue("link", link);

  void loadRoom(String link) async {
    final failureOrRoom = await roomApiService.get(link);

    print(failureOrRoom);
  }
}