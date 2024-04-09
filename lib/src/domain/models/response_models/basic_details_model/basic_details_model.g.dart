// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicDetailsModel _$BasicDetailsModelFromJson(Map<String, dynamic> json) =>
    BasicDetailsModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$BasicDetailsModelToJson(BasicDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mobile': instance.mobile,
      'email': instance.email,
      'status_code': instance.statusCode,
    };
