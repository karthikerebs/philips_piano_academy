// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonResponseModel _$CommonResponseModelFromJson(Map<String, dynamic> json) =>
    CommonResponseModel(
      message: json['message'] as String?,
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$CommonResponseModelToJson(
        CommonResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status_code': instance.statusCode,
    };
