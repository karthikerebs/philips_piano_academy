import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends Equatable {
  final String? token;
  final String? name;
  @JsonKey(name: 'class_mode')
  final String? classMode;
  final int? slote;
  final String? message;
  @JsonKey(name: 'status_code')
  final String? statusCode;
  final String? status;
  final String? approval;

  const LoginModel(
      {this.token,
      this.name,
      this.classMode,
      this.slote,
      this.message,
      this.statusCode,
      this.status,
      this.approval});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return _$LoginModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  LoginModel copyWith(
      {String? token,
      String? name,
      String? classMode,
      int? slote,
      String? message,
      String? statusCode,
      String? approval,
      String? status}) {
    return LoginModel(
        token: token ?? this.token,
        name: name ?? this.name,
        classMode: classMode ?? this.classMode,
        slote: slote ?? this.slote,
        message: message ?? this.message,
        statusCode: statusCode ?? this.statusCode,
        approval: approval ?? this.approval,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props {
    return [
      token,
      name,
      classMode,
      slote,
      message,
      statusCode,
      status,
      approval
    ];
  }
}
