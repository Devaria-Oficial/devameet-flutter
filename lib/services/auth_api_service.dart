import 'package:dartz/dartz.dart';
import 'package:devameet_flutter/errors/failures.dart';
import 'package:devameet_flutter/models/auth_model.dart';
import 'package:devameet_flutter/services/http_service.dart';

abstract class AuthApiService {
  Future<Either<Failure, AuthModel>> login(String email, String password);
}

class AuthApiServiceImpl implements AuthApiService {
  final HttpService httpService;

  AuthApiServiceImpl({required this.httpService});

  @override
  Future<Either<Failure, AuthModel>> login(
      String email, String password) async {
    final result = await httpService.request(
        path: "/auth/login",
        method: "POST",
        data: {"login": email, "password": password});

    return result.fold((failure) {
      failure as ApiFailure;
      final msg = failure.message ?? (failure.response.data["message"]);
      return Left(AppFailure(msg));
    }, (response) => Right(AuthModel.fromJson(response.data)));
  }
}
