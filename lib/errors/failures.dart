
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ApiFailure extends Failure {
  final int statusCode;
  final String? message;
  final dynamic response;

  ApiFailure({this.statusCode = 500, this.message, this.response});

  @override
  List<Object?> get props => [statusCode, message];

}

class AppFailure extends Failure {
  final String error;

  AppFailure(this.error);

  @override
  List<Object?> get props => [error];


}