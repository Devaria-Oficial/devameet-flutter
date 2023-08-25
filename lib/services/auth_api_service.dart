import 'package:devameet_flutter/errors/failures.dart';
import 'package:devameet_flutter/services/http_service.dart';

abstract class AuthApiService {
  void login(String email, String password);
}

class AuthApiServiceImpl implements AuthApiService {
  final HttpService httpService;

  AuthApiServiceImpl({required this.httpService});

  @override
  void login(String email, String password) async {
    final result = await httpService.request(
        path: "/auth/login",
        method: "POST",
        data: {"login": email, "password": password});

    result.fold((failure) {
        failure as ApiFailure;
        final msg = failure.message ?? (failure.response.data["message"]);
        print(msg);
        }
        , (r) => print(r));
  }
}
