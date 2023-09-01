
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {

  RoomCubit() : super(RoomState.initial());
}