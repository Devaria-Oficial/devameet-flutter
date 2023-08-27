import 'dart:async';

import 'package:devameet_flutter/views/login.dart';
import 'package:devameet_flutter/views/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubits/app/app_cubit.dart';

class PrivatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Exemplo de pagina privada"),
              ElevatedButton(
                  onPressed: context.read<AppCubit>().performLogout,
                  child: Text("Deslogar"))
            ],
          ),
        );
      }),
    );
  }
}

class AppRouter {
  final AppCubit appCubit;

  AppRouter({required this.appCubit});

  late final GoRouter router = GoRouter(
      routes: [
        GoRoute(path: "/", builder: (context, state) => PrivatePage()),
        GoRoute(path: "/sign_up", builder: (context, state) => RegisterPage()),
        GoRoute(path: "/sign_in", builder: (context, state) => LoginPage()),
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
