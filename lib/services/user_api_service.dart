import 'package:dartz/dartz.dart';
import 'package:devameet_flutter/errors/failures.dart';
import 'package:devameet_flutter/models/user_model.dart';
import 'package:devameet_flutter/services/http_service.dart';

abstract class UserApiService {
  Future<Either<Failure, UserModel>> get();
}

class UserApiServiceImpl implements UserApiService {
  final HttpService httpService;

  UserApiServiceImpl({required this.httpService});

  @override
  Future<Either<Failure, UserModel>> get() async {
    final result = await httpService.request(path: "/user", method: "GET");

    return result.fold((l) => Left(AppFailure("Cannot load user")),
        (response) => Right(UserModel.fromJson(response.data)));
  }
}
