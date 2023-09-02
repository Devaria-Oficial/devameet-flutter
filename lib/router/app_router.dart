import 'dart:async';

import 'package:devameet_flutter/cubits/app/app_cubit.dart';
import 'package:devameet_flutter/views/entrance_room.dart';
import 'package:devameet_flutter/views/login.dart';
import 'package:devameet_flutter/views/my_meets.dart';
import 'package:devameet_flutter/views/profile.dart';
import 'package:devameet_flutter/views/register.dart';
import 'package:devameet_flutter/views/room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';


class AppRouter {
  final AppCubit appCubit;

  AppRouter({required this.appCubit});

  late final GoRouter router = GoRouter(
      routes: [
        GoRoute(path: "/", builder: (context, state) => MyMeetsPage()),
        GoRoute(path: "/profile", builder: (context, state) => ProfilePage()),
        GoRoute(path: "/sign_up", builder: (context, state) => RegisterPage()),
        GoRoute(path: "/sign_in", builder: (context, state) => LoginPage()),
        GoRoute(path: "/entrance_room", name: "entrance_room", builder: (context, state) {

          print(state.uri.queryParameters);

          return EntranceRoomPage();
        }),
        GoRoute(path: "/room/:link", builder: (context, state) => RoomPage(link: state.pathParameters["link"]!,))

      ],
      redirect: (context, state) {
        final logged = appCubit.state.status == AppStatus.authenticated;
        final publicRoutes = ['/sign_in', '/sign_up'];

        if (!logged & !publicRoutes.contains(state.fullPath)) {
          return "/sign_in";
        }

        if (logged && publicRoutes.contains(state.fullPath)) {
          return '/';
        }

        return null;
      },
      refreshListenable: GoRouterRefreshStream(appCubit.stream));
}

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription =
        stream.asBroadcastStream().listen((dynamic _) => notifyListeners());
  }
}
