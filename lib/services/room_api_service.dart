import 'package:dartz/dartz.dart';
import 'package:devameet_flutter/errors/failures.dart';
import 'package:devameet_flutter/models/room_model.dart';
import 'package:devameet_flutter/services/http_service.dart';

abstract class RoomApiService {
  Future<Either<Failure, RoomModel>> get(String link);
}

class RoomApiServiceImpl implements RoomApiService {
  final HttpService httpService;

  RoomApiServiceImpl({required this.httpService});

  @override
  Future<Either<Failure, RoomModel>> get(String link) async {
    final result =
        await httpService.request(path: "/room/$link", method: "GET");

    return result.fold((failure) => Left(AppFailure("Cannot get room")),
        (response) => Right(RoomModel.fromJson(response.data)));
  }
}
