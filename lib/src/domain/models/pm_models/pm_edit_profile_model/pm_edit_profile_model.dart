import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pm_edit_profile_model.g.dart';

@JsonSerializable()
class PmEditProfileModel extends Equatable {
  final String? name;
  final String? address;
  @JsonKey(name: 'alternative_mobile')
  final String? alternativeMobile;
  final String? dob;
  final String? guardian;

  const PmEditProfileModel({
    this.name,
    this.address,
    this.alternativeMobile,
    this.dob,
    this.guardian,
  });

  factory PmEditProfileModel.fromJson(Map<String, dynamic> json) {
    return _$PmEditProfileModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PmEditProfileModelToJson(this);

  PmEditProfileModel copyWith({
    String? name,
    String? address,
    String? alternativeMobile,
    String? dob,
    String? guardian,
  }) {
    return PmEditProfileModel(
      name: name ?? this.name,
      address: address ?? this.address,
      alternativeMobile: alternativeMobile ?? this.alternativeMobile,
      dob: dob ?? this.dob,
      guardian: guardian ?? this.guardian,
    );
  }

  @override
  List<Object?> get props {
    return [
      name,
      address,
      alternativeMobile,
      dob,
      guardian,
    ];
  }
}
