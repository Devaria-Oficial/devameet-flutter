

part of 'room_cubit.dart';

enum RoomStatus { initial, loading, success, notFound, roomBuilt, enterMeet}

class RoomState extends Equatable {

  final RoomStatus status;
  final RoomModel? room;
  final FormHandler form;
  final List<RoomRenderItemModel> roomRenderItems;

  RoomState({required this.form, required this.status, required this.room, required this.roomRenderItems});

  @override
  List<Object?> get props => [status, room, roomRenderItems];

  factory RoomState.initial() {
    return RoomState(
      status: RoomStatus.initial,
      roomRenderItems: [],
      room: null,
      form: FormHandler({
        "link": FormInput<String>('', validator: Validator().required("Preencha o link da reunião"))
      })
    );
  }

  RoomState copyWith({RoomStatus? status, RoomModel? room, FormHandler? form, List<RoomRenderItemModel>? roomRenderItems}) {
    return RoomState(
      status: status ?? this.status,
      room: room ?? this.room,
      form: form ?? this.form,
      roomRenderItems: roomRenderItems ?? this.roomRenderItems
    );
  }

}