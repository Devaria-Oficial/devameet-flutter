

import 'package:devameet_flutter/cubits/meet/meet_cubit.dart';
import 'package:devameet_flutter/cubits/profile/profile_cubit.dart';
import 'package:devameet_flutter/cubits/register/register_cubit.dart';
import 'package:devameet_flutter/cubits/room/room_cubit.dart';
import 'package:devameet_flutter/cubits/room_ws/room_ws_cubit.dart';
import 'package:devameet_flutter/services/auth_api_service.dart';
import 'package:devameet_flutter/services/http_service.dart';
import 'package:devameet_flutter/services/meet_api_service.dart';
import 'package:devameet_flutter/services/peer_connection_service.dart';
import 'package:devameet_flutter/services/room_api_service.dart';
import 'package:devameet_flutter/services/room_render_service.dart';
import 'package:devameet_flutter/services/room_ws_service.dart';
import 'package:devameet_flutter/services/socket_service.dart';
import 'package:devameet_flutter/services/user_api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'cubits/app/app_cubit.dart';
import 'cubits/login/login_cubit.dart';

final sl = GetIt.instance;

void init() {
  // SERVICES
  sl.registerLazySingleton<AuthApiService>(() => AuthApiServiceImpl(httpService: sl(), secureStorage: sl()));
  sl.registerLazySingleton<UserApiService>(() => UserApiServiceImpl(httpService: sl()));
  sl.registerLazySingleton<MeetApiService>(() => MeetApiServiceImpl(httpService: sl()));
  sl.registerLazySingleton<RoomApiService>(() => RoomApiServiceImpl(httpService: sl()));
  sl.registerLazySingleton<RoomRenderService>(() => RoomRenderServiceImpl());
  sl.registerLazySingleton<RoomWsService>(() => RoomWsServiceImpl(socketService: sl(), peerConnectionService: sl()));

  // CUBITS
  sl.registerFactory(() => LoginCubit(authApiService: sl()));
  sl.registerFactory(() => RegisterCubit(authApiService: sl()));
  sl.registerFactory(() => AppCubit(authApiService: sl(), httpService: sl()));
  sl.registerFactory(() => ProfileCubit(userApiService: sl()));
  sl.registerFactory(() => MeetCubit(meetApiService: sl()));
  sl.registerFactory(() => RoomCubit(roomApiService: sl(), roomRenderService: sl()));
  sl.registerFactory(() => RoomWsCubit(roomWsService: sl(), roomRenderService: sl()));

  // CORE
  sl.registerLazySingleton<HttpService>(() => HttpServiceImpl(dotenv.get("API_URL")));
  sl.registerLazySingleton<SocketService>(() => SocketServiceImpl(dotenv.get("WS_URL")));
  sl.registerFactory<PeerConnectionService>(() => PeerConnectionService());

  // External
  sl.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());

}
