

import 'package:devameet_flutter/views/login.dart';
import 'package:devameet_flutter/views/register.dart';
import 'package:go_router/go_router.dart';

class AppRouter {

  late final GoRouter router = GoRouter(routes: [
    GoRoute(path: "/", builder: (context, state) => LoginPage()),
    GoRoute(path: "/sign_up", builder: (context, state) => RegisterPage()),
    GoRoute(path: "/sign_in", builder: (context, state) => LoginPage()),

  ]);
}