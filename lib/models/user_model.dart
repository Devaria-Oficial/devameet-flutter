import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String avatar;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
  });

  @override
  List<Object?> get props => [id, name, email, avatar];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
    };
  }

  UserModel copyWith({String? name, String? avatar}) {
    return UserModel(
        id: id,
        name: name ?? this.name,
        email: email,
        avatar: avatar ?? this.avatar);
  }
}
