// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterModel _$RegisterModelFromJson(Map<String, dynamic> json) =>
    RegisterModel(
      message: json['message'] as String?,
      token: json['token'] as String?,
      name: json['name'] as String?,
      classMode: json['class_mode'] as String?,
      slote: json['slote'] as int?,
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$RegisterModelToJson(RegisterModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'token': instance.token,
      'name': instance.name,
      'class_mode': instance.classMode,
      'slote': instance.slote,
      'status_code': instance.statusCode,
    };
