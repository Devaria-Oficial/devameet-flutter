

import 'package:equatable/equatable.dart';

class MeetModel extends Equatable {
  final String id;
  final String name;
  final String color;
  final String link;

  const MeetModel({
    required this.id,
    required this.name,
    required this.color,
    required this.link,
  });

  @override
  List<Object?> get props => [id, name, color, link];

  factory MeetModel.fromJson(Map<String, dynamic> json) {
    return MeetModel(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      link: json['link'],
    );
  }

}