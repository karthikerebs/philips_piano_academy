// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      token: json['token'] as String?,
      name: json['name'] as String?,
      classMode: json['class_mode'] as String?,
      slote: json['slote'] as int?,
      message: json['message'] as String?,
      statusCode: json['status_code'] as String?,
      status: json['status'] as String?,
      approval: json['approval'] as String?,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'name': instance.name,
      'class_mode': instance.classMode,
      'slote': instance.slote,
      'message': instance.message,
      'status_code': instance.statusCode,
      'status': instance.status,
      'approval': instance.approval,
    };
