// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      profileDetails: json['profile_details'] == null
          ? null
          : ProfileDetails.fromJson(
              json['profile_details'] as Map<String, dynamic>),
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'profile_details': instance.profileDetails,
      'status_code': instance.statusCode,
    };
