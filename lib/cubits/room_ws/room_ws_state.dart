
part of 'room_ws_cubit.dart';

class RoomWsState extends Equatable {

  final List<PlayerRenderItem> playerRenderItems;
  final bool muted;

  const RoomWsState({
    required this.playerRenderItems,
    required this.muted
  });

  @override
  List<Object?> get props => [playerRenderItems, muted];


  factory RoomWsState.initial() {
    return RoomWsState(playerRenderItems: [], muted: false);
  }

  RoomWsState copyWith({List<PlayerRenderItem>? playerRenderItems, bool? muted}) {
    return RoomWsState(
        playerRenderItems: playerRenderItems ?? this.playerRenderItems,
        muted: muted ?? this.muted
    );
  }

}