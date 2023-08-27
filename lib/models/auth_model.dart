
import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String name;
  final String email;
  final String token;

  const AuthModel({required this.name, required this.email, required this.token});

  @override
  List<Object?> get props => [name, email, token];


  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(name: json['name'], email: json['email'], token: json['token']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'token': token
    };
  }

}