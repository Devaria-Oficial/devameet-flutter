

import 'package:devameet_flutter/services/http_service.dart';

abstract class UserApiService {
  void get();
}

class UserApiServiceImpl implements UserApiService {
  final HttpService httpService;

  UserApiServiceImpl({required this.httpService});

  @override
  void get() async {
    final result = await httpService.request(path: "/user", method: "GET");

    result.fold((l) => print(l), (r) => print(r));
  }

}