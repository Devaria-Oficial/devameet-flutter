
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_stream_handler/form_stream_handler.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {

  RoomCubit() : super(RoomState.initial());

  void changeLink(link) => state.form.setValue("link", link);
}