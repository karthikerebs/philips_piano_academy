// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pm_register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PmRegisterModel _$PmRegisterModelFromJson(Map<String, dynamic> json) =>
    PmRegisterModel(
      name: json['name'] as String?,
      dob: json['dob'] as String?,
      guardian: json['guardian'] as String?,
      mobile: json['mobile'] as String?,
      alternativeMobile: json['alternative_mobile'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      classMode: json['class_mode'] as String?,
      branch: json['branch'] as String?,
      password: json['password'] as String?,
      username: json['username'] as String?,
    );

Map<String, dynamic> _$PmRegisterModelToJson(PmRegisterModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dob': instance.dob,
      'guardian': instance.guardian,
      'mobile': instance.mobile,
      'alternative_mobile': instance.alternativeMobile,
      'email': instance.email,
      'address': instance.address,
      'class_mode': instance.classMode,
      'branch': instance.branch,
      'password': instance.password,
      'username': instance.username,
    };
