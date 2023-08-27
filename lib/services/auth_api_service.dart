import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:devameet_flutter/errors/failures.dart';
import 'package:devameet_flutter/models/auth_model.dart';
import 'package:devameet_flutter/services/http_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthApiService {
  Future<Either<Failure, AuthModel>> login(String email, String password);
  Future<Either<Failure, void>> register(
      {required String email,
      required String password,
      required String name,
      required String avatar});
  Future<void> saveAuthLocal(AuthModel auth);
}

enum StorageKeys {
  auth
}

class AuthApiServiceImpl implements AuthApiService {
  final HttpService httpService;
  final FlutterSecureStorage secureStorage;

  AuthApiServiceImpl({required this.httpService, required this.secureStorage});

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

  @override
  Future<Either<Failure, void>> register(
      {required String email,
      required String password,
      required String name,
      required String avatar}) async {
    final result = await httpService.request(
        path: "/auth/register",
        method: "POST",
        data: {
          "email": email,
          "password": password,
          "name": name,
          "avatar": avatar
        });

    return result.fold((failure) {
      failure as ApiFailure;
      dynamic msg = failure.message ?? (failure?.response?.data["message"]);

      if (msg is List) msg = msg.join(", ");
      return Left(AppFailure(msg));
    }, (response) => const Right(null));
  }

  @override
  Future<void> saveAuthLocal(AuthModel auth) async {
    await secureStorage.write(key: StorageKeys.auth.toString(), value: jsonEncode(auth));
  }
}
