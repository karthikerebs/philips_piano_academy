// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_renewal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckRenewalResponse _$CheckRenewalResponseFromJson(
        Map<String, dynamic> json) =>
    CheckRenewalResponse(
      message: json['message'] as String?,
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$CheckRenewalResponseToJson(
        CheckRenewalResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status_code': instance.statusCode,
    };
