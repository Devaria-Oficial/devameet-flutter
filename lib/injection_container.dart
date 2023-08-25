

import 'package:devameet_flutter/services/auth_api_service.dart';
import 'package:devameet_flutter/services/http_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import 'cubits/login/login_cubit.dart';

final sl = GetIt.instance;

void init() {
  // SERVICES
  sl.registerLazySingleton<AuthApiService>(() => AuthApiServiceImpl(httpService: sl()));

  // CUBITS
  sl.registerFactory(() => LoginCubit(authApiService: sl()));

  // CORE
  sl.registerLazySingleton<HttpService>(() => HttpServiceImpl(dotenv.get("API_URL")));
}
