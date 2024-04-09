import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_details.g.dart';

@JsonSerializable()
class ProfileDetails extends Equatable {
  final String? name;
  final String? mobile;
  @JsonKey(name: 'alternative_mobile')
  final String? alternativeMobile;
  final String? email;
  final String? address;
  final String? dob;
  final String? guardian;
  @JsonKey(name: 'class_mode')
  final String? classMode;
  @JsonKey(name: 'valid_from')
  final String? validFrom;
  @JsonKey(name: 'valid_to')
  final String? validTo;
  final String? approval;
  final String? status;
  @JsonKey(name: 'slote_day')
  final String? sloteDay;
  @JsonKey(name: 'slote_time')
  final String? sloteTime;
  final String? photo;
  @JsonKey(name: 'profile_edit')
  final String? profileEdit;
  final String? username;
  @JsonKey(name: 'emergency_cancel')
  final int? emergencyCancel;
  final String? branch;

  const ProfileDetails(
      {this.name,
      this.mobile,
      this.alternativeMobile,
      this.email,
      this.address,
      this.dob,
      this.guardian,
      this.classMode,
      this.validFrom,
      this.validTo,
      this.approval,
      this.status,
      this.sloteDay,
      this.sloteTime,
      this.photo,
      this.profileEdit,
      this.username,
      this.emergencyCancel,
      this.branch});

  factory ProfileDetails.fromJson(Map<String, dynamic> json) {
    return _$ProfileDetailsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileDetailsToJson(this);

  ProfileDetails copyWith(
      {String? name,
      String? mobile,
      String? alternativeMobile,
      String? email,
      String? address,
      String? dob,
      String? guardian,
      String? classMode,
      String? validFrom,
      String? validTo,
      String? approval,
      String? status,
      String? sloteDay,
      String? sloteTime,
      String? photo,
      String? profileEdit,
      String? username,
      int? emergencyCancel,
      String? branch}) {
    return ProfileDetails(
        name: name ?? this.name,
        mobile: mobile ?? this.mobile,
        alternativeMobile: alternativeMobile ?? this.alternativeMobile,
        email: email ?? this.email,
        address: address ?? this.address,
        dob: dob ?? this.dob,
        guardian: guardian ?? this.guardian,
        classMode: classMode ?? this.classMode,
        validFrom: validFrom ?? this.validFrom,
        validTo: validTo ?? this.validTo,
        approval: approval ?? this.approval,
        status: status ?? this.status,
        sloteDay: sloteDay ?? this.sloteDay,
        sloteTime: sloteTime ?? this.sloteTime,
        photo: photo ?? this.photo,
        profileEdit: profileEdit ?? this.profileEdit,
        username: username ?? this.username,
        emergencyCancel: emergencyCancel ?? this.emergencyCancel,
        branch: branch ?? this.branch);
  }

  @override
  List<Object?> get props {
    return [
      name,
      mobile,
      alternativeMobile,
      email,
      address,
      dob,
      guardian,
      classMode,
      validFrom,
      validTo,
      approval,
      status,
      sloteDay,
      sloteTime,
      photo,
      profileEdit,
      username,
      emergencyCancel,
      branch
    ];
  }
}
