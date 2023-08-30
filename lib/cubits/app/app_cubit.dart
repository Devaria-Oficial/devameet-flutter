import 'package:devameet_flutter/models/auth_model.dart';
import 'package:devameet_flutter/services/auth_api_service.dart';
import 'package:devameet_flutter/services/http_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AuthApiService authApiService;
  final HttpService httpService;

  AppCubit({required this.authApiService, required this.httpService}) : super(AppState.initial());

  void init() async {
    final failureOrAuth = await authApiService.getLatestLogin();

    print(failureOrAuth);

    failureOrAuth.fold(
        (l) => emit(state.copyWith(status: AppStatus.unauthenticated)),
        (auth) => _performLogin(auth));
  }

  void _performLogin(AuthModel auth) {
    httpService.addHeader({"Authorization": "Bearer ${auth.token}"});
    emit(state.copyWith(status: AppStatus.authenticated));
  }

  void performLogin(AuthModel auth) {
    authApiService.saveAuthLocal(auth);
    _performLogin(auth);
  }

  void performLogout() {
    authApiService.cleanAuthLocal();
    emit(state.copyWith(status: AppStatus.unauthenticated));
  }
}
