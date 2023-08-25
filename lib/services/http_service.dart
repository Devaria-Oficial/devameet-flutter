

import 'package:dartz/dartz.dart';
import 'package:devameet_flutter/errors/failures.dart';
import 'package:dio/dio.dart';



abstract class HttpService {
  Future<Either<Failure, Response>> request({required String path, required String method, Map<String, dynamic>? data });
}

class HttpClientImpl implements HttpService {
  late Dio client;

  HttpClientImpl(String baseUrl) {
    final options = BaseOptions(baseUrl: baseUrl);
    client = Dio(options);
  }

  @override
  Future<Either<Failure, Response>> request({required String path, required String method, Map<String, dynamic>? data}) async {
    try {
      final response = await client.request(path, data: data, options: Options(method: method));
      return Right(response);
    } on DioException catch(e) {
      return Left(ApiFailure(statusCode: 500, response: e.response));
    }
  }
}


