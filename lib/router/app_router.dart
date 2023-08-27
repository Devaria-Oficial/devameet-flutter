

import 'dart:async';

import 'package:devameet_flutter/views/login.dart';
import 'package:devameet_flutter/views/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../cubits/app/app_cubit.dart';

class AppRouter {

  final AppCubit appCubit;

  AppRouter({required this.appCubit});

  late final GoRouter router = GoRouter(routes: [
    GoRoute(path: "/", builder: (context, state) => RegisterPage()),
    GoRoute(path: "/sign_up", builder: (context, state) => RegisterPage()),
    GoRoute(path: "/sign_in", builder: (context, state) => LoginPage()),

  ],
  redirect: (context, state) {
    print(appCubit.state.status);
  },
  refreshListenable: GoRouterRefreshStream(appCubit.stream)

  );
}

class GoRouterRefreshStream extends ChangeNotifier {

  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((dynamic _) => notifyListeners());
  }
}

