// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeeDetailsModel _$FeeDetailsModelFromJson(Map<String, dynamic> json) =>
    FeeDetailsModel(
      fee: json['fee'] as num?,
      extraFee: json['extra_fee'] as num?,
      deposit: json['deposit'] as String?,
      joiningDate: json['joining_date'] as String?,
      validFrom: json['valid_from'] as String?,
      validTo: json['valid_to'] as String?,
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$FeeDetailsModelToJson(FeeDetailsModel instance) =>
    <String, dynamic>{
      'fee': instance.fee,
      'extra_fee': instance.extraFee,
      'deposit': instance.deposit,
      'joining_date': instance.joiningDate,
      'valid_from': instance.validFrom,
      'valid_to': instance.validTo,
      'status_code': instance.statusCode,
    };
