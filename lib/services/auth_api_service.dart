

import 'package:devameet_flutter/services/http_service.dart';

abstract class AuthApiService {
  void login(String email, String password);
}

class AuthApiServiceImpl implements AuthApiService {
  final HttpService httpService;

  AuthApiServiceImpl({required this.httpService});

  @override
  void login(String email, String password) async {
    print(email);
    print(password);
  }

}



