import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'meet_state.dart';


class MeetCubit extends Cubit<MeetState> {

  MeetCubit() : super(MeetState.initial());
}
