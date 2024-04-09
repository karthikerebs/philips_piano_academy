// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDetails _$ProfileDetailsFromJson(Map<String, dynamic> json) =>
    ProfileDetails(
      name: json['name'] as String?,
      mobile: json['mobile'] as String?,
      alternativeMobile: json['alternative_mobile'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      dob: json['dob'] as String?,
      guardian: json['guardian'] as String?,
      classMode: json['class_mode'] as String?,
      validFrom: json['valid_from'] as String?,
      validTo: json['valid_to'] as String?,
      approval: json['approval'] as String?,
      status: json['status'] as String?,
      sloteDay: json['slote_day'] as String?,
      sloteTime: json['slote_time'] as String?,
      photo: json['photo'] as String?,
      profileEdit: json['profile_edit'] as String?,
      username: json['username'] as String?,
      emergencyCancel: json['emergency_cancel'] as int?,
      branch: json['branch'] as String?,
    );

Map<String, dynamic> _$ProfileDetailsToJson(ProfileDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobile': instance.mobile,
      'alternative_mobile': instance.alternativeMobile,
      'email': instance.email,
      'address': instance.address,
      'dob': instance.dob,
      'guardian': instance.guardian,
      'class_mode': instance.classMode,
      'valid_from': instance.validFrom,
      'valid_to': instance.validTo,
      'approval': instance.approval,
      'status': instance.status,
      'slote_day': instance.sloteDay,
      'slote_time': instance.sloteTime,
      'photo': instance.photo,
      'profile_edit': instance.profileEdit,
      'username': instance.username,
      'emergency_cancel': instance.emergencyCancel,
      'branch': instance.branch,
    };
