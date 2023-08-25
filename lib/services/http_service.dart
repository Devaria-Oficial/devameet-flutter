

import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:devameet_flutter/errors/failures.dart';
import 'package:dio/dio.dart';



abstract class HttpService {
  Future<Either<Failure, Response>> request({required String path, required String method, Map<String, dynamic>? data });
}

abstract class HttpMessages {
  static final INTERNAL_ERROR = "Erro Interno";
  static final CONNECTION_ERROR = "Não foi possivel estabelecer uma conexão com o servidor. Tente novamente mais tarde!";
}

class HttpServiceImpl implements HttpService {
  late Dio client;

  HttpServiceImpl(String baseUrl) {
    final options = BaseOptions(baseUrl: baseUrl);
    client = Dio(options);
  }

  @override
  Future<Either<Failure, Response>> request({required String path, required String method, Map<String, dynamic>? data}) async {
    try {
      final response = await client.request(path, data: data, options: Options(method: method));
      return Right(response);
    } on DioException catch(e) {

      if (e.isNoConnectionError) {
        return Left(ApiFailure( statusCode: 500, message: HttpMessages.CONNECTION_ERROR));
      }

      if (e.response == null) {
        return Left(ApiFailure(statusCode: 500, message: HttpMessages.INTERNAL_ERROR));
      }

      return Left(ApiFailure(statusCode: e.response?.statusCode as int, response: e.response));

    }
  }
}

extension DioExceptionX on DioException {
  bool get isNoConnectionError => type == DioExceptionType.unknown && error is SocketException;
}


