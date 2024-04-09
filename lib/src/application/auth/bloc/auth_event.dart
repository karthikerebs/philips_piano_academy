part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends AuthEvent {
  final PmRegisterModel pmRegisterModel;

  const RegisterEvent({required this.pmRegisterModel});
  @override
  List<Object> get props => [pmRegisterModel];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  final String fcmToken;
  const LoginEvent(
      {required this.username, required this.password, required this.fcmToken});
  @override
  List<Object> get props => [username, password, fcmToken];
}

class GetBrachesEvent extends AuthEvent {
  const GetBrachesEvent();
  @override
  List<Object> get props => [];
}

class CheckServerEvent extends AuthEvent {
  const CheckServerEvent();
  @override
  List<Object> get props => [];
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
  @override
  List<Object> get props => [];
}

class DeleteAccountEvent extends AuthEvent {
  const DeleteAccountEvent();

  @override
  List<Object> get props => [];
}
