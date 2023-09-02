import 'package:devameet_flutter/models/room_model.dart';
import 'package:devameet_flutter/services/room_api_service.dart';
import 'package:devameet_flutter/services/room_render_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_stream_handler/form_stream_handler.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  final RoomApiService roomApiService;
  final RoomRenderService roomRenderService;

  RoomCubit({required this.roomApiService, required this.roomRenderService}) : super(RoomState.initial());

  void changeLink(link) => state.form.setValue("link", link);

  void loadRoom(String link) async {
    emit(state.copyWith(status: RoomStatus.loading));

    final failureOrRoom = await roomApiService.get(link);

    failureOrRoom.fold((l) => emit(state.copyWith(status: RoomStatus.notFound)),
        (room) async {
          emit(state.copyWith(room: room, status: RoomStatus.success));

          final devameetAssets = await roomRenderService.getDevameetAssets();

          // room.objects.forEach((element) {
          //   print(element);
          // });

        });
  }
}
