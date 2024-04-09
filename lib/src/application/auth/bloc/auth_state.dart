part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState(
      {this.registerStatus = const StatusInitial(),
      this.loginStatus = const StatusInitial(),
      this.status = const StatusInitial(),
      this.branchList = const <Branch>[],
      this.loginResponse = const LoginModel(),
      this.serverCheckstatus = const StatusInitial(),
      this.logoutStatus = const StatusInitial(),
      this.deleteStatus = const StatusInitial()});
  final Status status;
  final Status registerStatus;
  final Status loginStatus;
  final List<Branch> branchList;
  final LoginModel loginResponse;
  final Status serverCheckstatus;
  final Status logoutStatus;
  final Status deleteStatus;
  @override
  List<Object> get props => [
        registerStatus,
        loginStatus,
        status,
        branchList,
        loginResponse,
        serverCheckstatus,
        logoutStatus,
        deleteStatus
      ];
  AuthState copyWith(
      {Status? registerStatus,
      Status? loginStatus,
      Status? status,
      LoginModel? loginResponse,
      List<Branch>? branchList,
      Status? serverCheckstatus,
      Status? logoutStatus,
      Status? deleteStatus}) {
    return AuthState(
        registerStatus: registerStatus ?? this.registerStatus,
        loginStatus: loginStatus ?? this.loginStatus,
        status: status ?? this.status,
        branchList: branchList ?? this.branchList,
        loginResponse: loginResponse ?? this.loginResponse,
        serverCheckstatus: serverCheckstatus ?? this.serverCheckstatus,
        logoutStatus: logoutStatus ?? this.logoutStatus,
        deleteStatus: deleteStatus ?? this.deleteStatus);
  }
}
