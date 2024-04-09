part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileDataEvent extends ProfileEvent {
  const GetProfileDataEvent();
  @override
  List<Object> get props => [];
}

class EditProfileEvent extends ProfileEvent {
  const EditProfileEvent({required this.params});
  final PmEditProfileModel params;
  @override
  List<Object> get props => [params];
}

class UploadProfileImageEvent extends ProfileEvent {
  final String filePath;
  const UploadProfileImageEvent({required this.filePath});
  @override
  List<Object> get props => [filePath];
}

class ChangePasswordEvent extends ProfileEvent {
  final String password;
  const ChangePasswordEvent({required this.password});
  @override
  List<Object> get props => [password];
}

class GetActivitiesEvent extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class GetNotiFyCount extends ProfileEvent {
  const GetNotiFyCount();

  @override
  List<Object> get props => [];
}

class GetReceiptsEvent extends ProfileEvent {
  const GetReceiptsEvent();

  @override
  List<Object> get props => [];
}

class GetBasicDetailsEvent extends ProfileEvent {
  const GetBasicDetailsEvent();

  @override
  List<Object> get props => [];
}
