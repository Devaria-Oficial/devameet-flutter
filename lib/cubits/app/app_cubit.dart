import 'package:devameet_flutter/models/auth_model.dart';
import 'package:devameet_flutter/services/auth_api_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AuthApiService authApiService;

  AppCubit({required this.authApiService}) : super(AppState.initial());

  void performLogin(AuthModel auth) {
    authApiService.saveAuthLocal(auth);
    emit(state.copyWith(status: AppStatus.authenticated));
  }
}