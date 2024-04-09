import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'profile_details.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends Equatable {
  @JsonKey(name: 'profile_details')
  final ProfileDetails? profileDetails;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const ProfileModel({this.profileDetails, this.statusCode});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return _$ProfileModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  ProfileModel copyWith({
    ProfileDetails? profileDetails,
    String? statusCode,
  }) {
    return ProfileModel(
      profileDetails: profileDetails ?? this.profileDetails,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [profileDetails, statusCode];
}
