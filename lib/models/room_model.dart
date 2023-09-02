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

