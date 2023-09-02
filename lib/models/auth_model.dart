import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String name;
  final String email;
  final String token;

  const AuthModel(
      {required this.name, required this.email, required this.token});

  @override
  List<Object?> get props => [name, email, token];

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
        name: json['name'], email: json['email'], token: json['token']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'token': token};
  }
}

class PlayerModel extends Equatable {
  final String userId;
  final String clientId;
  final String name;
  final int x;
  final int y;
  final String orientation;
  final bool muted;

  const PlayerModel(
      {required this.userId,
      required this.clientId,
      required this.name,
      required this.x,
      required this.y,
      required this.orientation,
      required this.muted});

  @override
  List<Object?> get props => [userId, clientId, name, x, y, orientation, muted];

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
        userId: json['userId'] ?? json['user'],
        clientId: json['clientId'],
        name: json['name'],
        x: json['x'],
        y: json['y'],
        orientation: json['orientation'],
        muted: json['muted']);
  }

  PlayerModel copyWith(
      {String? userId,
      String? clientId,
      String? name,
      int? x,
      int? y,
      String? orientation,
      bool? muted}) {
    return PlayerModel(
        userId: userId ?? this.userId,
        clientId: clientId ?? this.clientId,
        name: name ?? this.name,
        x: x ?? this.x,
        y: y ?? this.y,
        orientation: orientation ?? this.orientation,
        muted: muted ?? this.muted);
  }
}
