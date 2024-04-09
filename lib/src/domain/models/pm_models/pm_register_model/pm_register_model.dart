import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pm_register_model.g.dart';

@JsonSerializable()
class PmRegisterModel extends Equatable {
  final String? name;
  final String? dob;
  final String? guardian;
  final String? mobile;
  @JsonKey(name: 'alternative_mobile')
  final String? alternativeMobile;
  final String? email;
  final String? address;
  @JsonKey(name: 'class_mode')
  final String? classMode;
  final String? branch;
  final String? password;
  final String? username;

  const PmRegisterModel({
    this.name,
    this.dob,
    this.guardian,
    this.mobile,
    this.alternativeMobile,
    this.email,
    this.address,
    this.classMode,
    this.branch,
    this.password,
    this.username,
  });

  factory PmRegisterModel.fromJson(Map<String, dynamic> json) {
    return _$PmRegisterModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PmRegisterModelToJson(this);

  PmRegisterModel copyWith({
    String? name,
    String? dob,
    String? guardian,
    String? mobile,
    String? alternativeMobile,
    String? email,
    String? address,
    String? classMode,
    String? branch,
    String? password,
    String? username,
  }) {
    return PmRegisterModel(
        name: name ?? this.name,
        dob: dob ?? this.dob,
        guardian: guardian ?? this.guardian,
        mobile: mobile ?? this.mobile,
        alternativeMobile: alternativeMobile ?? this.alternativeMobile,
        email: email ?? this.email,
        address: address ?? this.address,
        classMode: classMode ?? this.classMode,
        branch: branch ?? this.branch,
        password: password ?? this.password,
        username: username ?? this.username);
  }

  @override
  List<Object?> get props {
    return [
      name,
      dob,
      guardian,
      mobile,
      alternativeMobile,
      email,
      address,
      classMode,
      branch,
      password,
      username
    ];
  }
}
