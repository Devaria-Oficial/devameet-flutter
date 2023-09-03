import 'package:equatable/equatable.dart';

class RoomObjectModel extends Equatable {
  final String name;
  final int x;
  final int y;
  final int zIndex;
  final String orientation;

  const RoomObjectModel(
      {required this.name,
      required this.x,
      required this.y,
      required this.zIndex,
      required this.orientation});

  @override
  List<Object?> get props => [name, x, y, zIndex, orientation];

  factory RoomObjectModel.fromJson(Map<String, dynamic> json) {
    return RoomObjectModel(
        name: json['name'],
        x: json['x'],
        y: json['y'],
        zIndex: json['zIndex'] ?? json['zindex'],
        orientation: json['orientation']);
  }
}

class RoomModel extends Equatable {
  final String link;
  final String name;
  final String color;
  final List<RoomObjectModel> objects;

  const RoomModel(
      {required this.link,
      required this.name,
      required this.color,
      required this.objects});

  @override
  List<Object?> get props => [link, name, color];

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
        link: json['link'],
        name: json['name'],
        color: json['color'],
        objects: List<RoomObjectModel>.from(json['objects']
            .map((roomObject) => RoomObjectModel.fromJson(roomObject)))
    );
  }
}


class DevameetAssetModel extends Equatable {
  final String name;
  final String source;
  final double scale;

  const DevameetAssetModel({
    required this.name,
    required this.source,
    required this.scale
  });

  @override
  List<Object?> get props => [name, source, scale];
}


class RoomRenderItemModel extends Equatable {
  final double top;
  final double left;
  final DevameetAssetModel asset;

  const RoomRenderItemModel({
    required this.top,
    required this.left,
    required this.asset
  });

  @override
  List<Object?> get props => [top, left, asset];
}

class PlayerModel extends Equatable {
  final String userId;
  final String clientId;
  final String name;
  final String avatar;
  final int x;
  final int y;
  final String orientation;
  final bool muted;

  const PlayerModel(
      {required this.userId,
        required this.clientId,
        required this.name,
        required this.avatar,
        required this.x,
        required this.y,
        required this.orientation,
        required this.muted});

  @override
  List<Object?> get props =>
      [userId, clientId, name, avatar, x, y, orientation, muted];

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
        userId: json['userId'] ?? json['user'],
        clientId: json['clientId'],
        name: json['name'],
        avatar: json['avatar'],
        x: json['x'],
        y: json['y'],
        orientation: json['orientation'],
        muted: json['muted']);
  }

  PlayerModel copyWith(
      {String? userId,
        String? clientId,
        String? name,
        String? avatar,
        int? x,
        int? y,
        String? orientation,
        bool? muted}) {
    return PlayerModel(
        userId: userId ?? this.userId,
        clientId: clientId ?? this.clientId,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        x: x ?? this.x,
        y: y ?? this.y,
        orientation: orientation ?? this.orientation,
        muted: muted ?? this.muted);
  }
}

class PlayerRenderItem extends Equatable {
  final PlayerModel player;
  final RoomRenderItemModel roomRenderItem;

  const PlayerRenderItem({required this.player, required this.roomRenderItem});

  @override
  List<Object?> get props => [player, roomRenderItem];
}