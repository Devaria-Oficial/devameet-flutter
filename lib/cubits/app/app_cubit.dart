import 'package:devameet_flutter/services/auth_api_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AuthApiService authApiService;

  AppCubit({required this.authApiService}) : super(AppState.initial());

  void performLogin() {
    print("Avisando pro App Cubit que estou logado");
    emit(state.copyWith(status: AppStatus.authenticated));
  }
}