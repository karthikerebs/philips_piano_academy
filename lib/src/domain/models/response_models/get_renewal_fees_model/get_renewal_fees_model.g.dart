// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_renewal_fees_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRenewalFeesModel _$GetRenewalFeesModelFromJson(Map<String, dynamic> json) =>
    GetRenewalFeesModel(
      renewalFee: json['renewal_fee'] as num?,
      extraClassFee: json['extra_class_fee'] as num?,
      statusCode: json['status_code'] as String?,
      extraClass: json['extra_class'] as num?,
    );

Map<String, dynamic> _$GetRenewalFeesModelToJson(
        GetRenewalFeesModel instance) =>
    <String, dynamic>{
      'renewal_fee': instance.renewalFee,
      'extra_class_fee': instance.extraClassFee,
      'status_code': instance.statusCode,
      'extra_class': instance.extraClass,
    };
