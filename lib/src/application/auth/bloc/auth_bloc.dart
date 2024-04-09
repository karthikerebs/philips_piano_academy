import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/domain/auth/i_auth_repository.dart';
import 'package:music_app/src/domain/core/failures/api_auth_failure.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/core/pref_key/preference_key.dart';
import 'package:music_app/src/domain/models/pm_models/pm_register_model/pm_register_model.dart';
import 'package:music_app/src/domain/models/response_models/branch_model/branch.dart';
import 'package:music_app/src/domain/models/response_models/login_model/login_model.dart';
import 'package:music_app/src/infrastructure/core/preference_helper.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.authRepository) : super(const AuthState()) {
    on<RegisterEvent>(_register);
    on<LoginEvent>(_login);
    on<GetBrachesEvent>(_getBranchList);
    on<CheckServerEvent>(_checkServer);
    on<LogoutEvent>(_logout);
    on<DeleteAccountEvent>(_deleteAccount);
  }
  FutureOr<void> _register(RegisterEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(registerStatus: StatusLoading()));
      final res =
          await authRepository.register(pmRegisterModel: event.pmRegisterModel);
      if (res.statusCode == '01') {
        emit(state.copyWith(registerStatus: StatusSuccess()));
      } else {
        emit(state.copyWith(
            registerStatus: StatusFailure(res.message ?? "Request fail")));
      }
    } on ApiFailure catch (e) {
      log(e.message);
      emit(state.copyWith(registerStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(registerStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(loginStatus: StatusLoading()));
      final res = await authRepository.login(
          fcmToken: event.fcmToken,
          username: event.username,
          password: event.password);
      if (res.statusCode == '01') {
        PreferenceHelper()
            .setString(key: AppPrefeKeys.token, value: res.token ?? '');
        PreferenceHelper().setBool(key: AppPrefeKeys.logged, value: true);
        PreferenceHelper()
            .setString(key: AppPrefeKeys.name, value: res.name ?? "");
        emit(state.copyWith(loginStatus: StatusSuccess(), loginResponse: res));
      } else {
        emit(state.copyWith(
            loginStatus: StatusFailure(res.message ?? "Request fail")));
      }
    } on ApiFailure catch (e) {
      log(e.message);
      emit(state.copyWith(loginStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(loginStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _getBranchList(
      GetBrachesEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: StatusLoading()));
      final res = await authRepository.getBranches();
      if (res.statusCode == '01') {
        emit(state.copyWith(status: StatusSuccess(), branchList: res.branches));
      } else {
        emit(state.copyWith(status: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      log(e.message);
      emit(state.copyWith(status: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(status: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _checkServer(
      CheckServerEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(serverCheckstatus: StatusLoading()));
      final res = await authRepository.serverCheck();
      if (res == true) {
        emit(state.copyWith(serverCheckstatus: StatusSuccess()));
      } else {
        emit(state.copyWith(
            serverCheckstatus: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      log(e.message);
      emit(state.copyWith(serverCheckstatus: StatusFailure(e.message)));
    }
  }

  FutureOr<void> _logout(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(logoutStatus: StatusLoading()));
      final res = await authRepository.logout();
      if (res.message == "Logged out successfully.") {
        emit(state.copyWith(logoutStatus: StatusSuccess()));
      } else {
        emit(state.copyWith(logoutStatus: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      log(e.message);
      emit(state.copyWith(logoutStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(logoutStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _deleteAccount(
      DeleteAccountEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(deleteStatus: StatusLoading()));
      final res = await authRepository.deleteAccount();
      if (res.message != null) {
        log("${res.toJson()}");
        emit(state.copyWith(deleteStatus: StatusSuccess()));
      } else {
        emit(state.copyWith(
            deleteStatus: StatusFailure(res.message ?? "Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(deleteStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(deleteStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  final IAuthRepository authRepository;
}
