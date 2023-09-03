
part of 'room_ws_cubit.dart';

class RoomWsState extends Equatable {

  final List<PlayerRenderItem> playerRenderItems;

  const RoomWsState({
    required this.playerRenderItems
  });

  @override
  List<Object?> get props => [playerRenderItems];


  factory RoomWsState.initial() {
    return RoomWsState(playerRenderItems: []);
  }

  RoomWsState copyWith({List<PlayerRenderItem>? playerRenderItems}) {
    return RoomWsState(
        playerRenderItems: playerRenderItems ?? this.playerRenderItems
    );
  }

}