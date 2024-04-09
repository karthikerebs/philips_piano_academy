part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState(
      {this.status = const StatusInitial(),
      this.profileData = const ProfileModel(),
      this.editProfilestatus = const StatusInitial(),
      this.uploadStatus = const StatusInitial(),
      this.changePasswordStatus = const StatusInitial(),
      this.activityStatus = const StatusInitial(),
      this.activityList = const <Activity>[],
      this.countStatus = const StatusInitial(),
      this.notifyCount = const NotificationCountModel(),
      this.receiptsStatus = const StatusInitial(),
      this.receiptsList = const <Receipt>[],
      this.detailsStatus = const StatusInitial(),
      this.basicData = const BasicDetailsModel()});
  final Status status;
  final ProfileModel profileData;
  final Status editProfilestatus;
  final Status uploadStatus;
  final Status changePasswordStatus;
  final Status activityStatus;
  final List<Activity> activityList;
  final Status countStatus;
  final NotificationCountModel notifyCount;
  final Status receiptsStatus;
  final List<Receipt> receiptsList;
  final Status detailsStatus;
  final BasicDetailsModel basicData;
  @override
  List<Object> get props => [
        status,
        profileData,
        editProfilestatus,
        uploadStatus,
        changePasswordStatus,
        activityStatus,
        activityList,
        countStatus,
        notifyCount,
        receiptsStatus,
        receiptsList,
        detailsStatus,
        basicData
      ];
  ProfileState copyWith(
      {Status? status,
      ProfileModel? profileData,
      Status? editProfilestatus,
      Status? uploadStatus,
      Status? changePasswordStatus,
      Status? activityStatus,
      List<Activity>? activityList,
      Status? countStatus,
      NotificationCountModel? notifyCount,
      Status? receiptsStatus,
      List<Receipt>? receiptsList,
      Status? detailsStatus,
      BasicDetailsModel? basicData}) {
    return ProfileState(
        status: status ?? this.status,
        profileData: profileData ?? this.profileData,
        editProfilestatus: editProfilestatus ?? this.editProfilestatus,
        uploadStatus: uploadStatus ?? this.uploadStatus,
        changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
        activityStatus: activityStatus ?? this.activityStatus,
        activityList: activityList ?? this.activityList,
        countStatus: countStatus ?? this.countStatus,
        notifyCount: notifyCount ?? this.notifyCount,
        receiptsStatus: receiptsStatus ?? this.receiptsStatus,
        receiptsList: receiptsList ?? this.receiptsList,
        basicData: basicData ?? this.basicData,
        detailsStatus: detailsStatus ?? this.detailsStatus);
  }
}
