part of 'room_ws_cubit.dart';

class RoomWsState extends Equatable {
  final List<PlayerRenderItem> playerRenderItems;
  final bool muted;
  final Map<String, RTCVideoRenderer> playerAudios;

  const RoomWsState(
      {required this.playerRenderItems,
      required this.muted,
      required this.playerAudios});

  @override
  List<Object?> get props => [playerRenderItems, muted, playerAudios];

  factory RoomWsState.initial() {
    return RoomWsState(playerRenderItems: [], muted: false, playerAudios: {});
  }

  RoomWsState copyWith(
      {List<PlayerRenderItem>? playerRenderItems,
      bool? muted,
      Map<String, RTCVideoRenderer>? playerAudios}) {
    return RoomWsState(
        playerRenderItems: playerRenderItems ?? this.playerRenderItems,
        muted: muted ?? this.muted,
        playerAudios: playerAudios ?? this.playerAudios);
  }
}
