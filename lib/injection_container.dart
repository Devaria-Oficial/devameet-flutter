

import 'package:devameet_flutter/services/auth_api_service.dart';
import 'package:devameet_flutter/services/http_service.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  // SERVICES
  sl.registerLazySingleton<AuthApiService>(() => AuthApiServiceImpl(httpService: sl()));

  // CORE
  sl.registerLazySingleton<HttpService>(() => HttpServiceImpl("https://devaria.com.br"));
}
