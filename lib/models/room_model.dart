
import 'package:equatable/equatable.dart';

class RoomModel extends Equatable {
  final String link;
  final String name;
  final String color;

  const RoomModel({
    required this.link,
    required this.name,
    required this.color
  });

  @override
  List<Object?> get props => [link, name, color];

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(link: json['link'], name: json['name'], color: json['color']);
  }
}