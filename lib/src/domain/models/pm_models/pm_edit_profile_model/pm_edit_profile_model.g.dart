// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pm_edit_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PmEditProfileModel _$PmEditProfileModelFromJson(Map<String, dynamic> json) =>
    PmEditProfileModel(
      name: json['name'] as String?,
      address: json['address'] as String?,
      alternativeMobile: json['alternative_mobile'] as String?,
      dob: json['dob'] as String?,
      guardian: json['guardian'] as String?,
    );

Map<String, dynamic> _$PmEditProfileModelToJson(PmEditProfileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'alternative_mobile': instance.alternativeMobile,
      'dob': instance.dob,
      'guardian': instance.guardian,
    };
