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
// import 'package:music_app/src/domain/models/response_models/profile_model/profile_details.dart';
// import 'package:music_app/src/domain/models/response_models/profile_model/profile_model.dart';

// ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
//   final profileDetailsJson = json['profile_details'];
//   ProfileDetails? profileDetails;

//   // Check if profile_details is a Map<String, dynamic>
//   if (profileDetailsJson is Map<String, dynamic>) {
//     profileDetails = ProfileDetails.fromJson(profileDetailsJson);
//   } else if (profileDetailsJson is String) {
//     // If profile_details is a String, handle it accordingly
//     // For example, you can create a default ProfileDetails object or handle the string in some other way
//     // Here, I'm just logging a message, but you should replace this with your actual handling logic
//     print('Profile details is a string: $profileDetailsJson');
//   }

//   return ProfileModel(
//     profileDetails: profileDetails,
//     statusCode: json['status_code'] as String?,
//   );
// }
