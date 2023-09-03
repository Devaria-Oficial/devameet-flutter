part of 'room_ws_cubit.dart';

class RoomWsState extends Equatable {
  final List<PlayerRenderItem> playerRenderItems;
  final Map<String, RTCVideoRenderer> playerAudios;

  const RoomWsState(
      {required this.playerRenderItems, required this.playerAudios});

  @override
  List<Object?> get props => [playerRenderItems];

  factory RoomWsState.initial() {
    return RoomWsState(playerRenderItems: [], playerAudios: {});
  }

  RoomWsState copyWith(
      {List<PlayerRenderItem>? playerRenderItems,
      Map<String, RTCVideoRenderer>? playerAudios}) {
    return RoomWsState(
        playerRenderItems: playerRenderItems ?? this.playerRenderItems,
        playerAudios: playerAudios ?? this.playerAudios);
  }
}
