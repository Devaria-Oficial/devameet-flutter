

import 'package:devameet_flutter/services/http_service.dart';

abstract class RoomApiService {
  void get(String link);
}

class RoomApiServiceImpl implements RoomApiService {
  final HttpService httpService;

  RoomApiServiceImpl({required this.httpService});

  @override
  void get(String link) async {
    final result = await httpService.request(path: "/room/$link", method: "GET");

    result.fold((failure) => print(failure), (response) => print(response));
  }

}