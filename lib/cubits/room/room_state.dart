

part of 'room_cubit.dart';

enum RoomStatus { initial, loading, success, notFound}

class RoomState extends Equatable {

  final RoomStatus status;
  final RoomModel? room;
  final FormHandler form;

  RoomState({required this.form, required this.status, required this.room});

  @override
  List<Object?> get props => [status, room];

  factory RoomState.initial() {
    return RoomState(
      status: RoomStatus.initial,
      room: null,
      form: FormHandler({
        "link": FormInput<String>('', validator: Validator().required("Preencha o link da reunião"))
      })
    );
  }

  RoomState copyWith({RoomStatus? status, RoomModel? room, FormHandler? form}) {
    return RoomState(
      status: status ?? this.status,
      room: room ?? this.room,
      form: form ?? this.form
    );
  }

}