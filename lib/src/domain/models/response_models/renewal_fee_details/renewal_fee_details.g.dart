// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'renewal_fee_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RenewalFeeDetails _$RenewalFeeDetailsFromJson(Map<String, dynamic> json) =>
    RenewalFeeDetails(
      fee: json['fee'] as num?,
      extraFee: json['extra_fee'] as num?,
      joiningDate: json['joining_date'] as String?,
      validFrom: json['valid_from'] as String?,
      validTo: json['valid_to'] as String?,
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$RenewalFeeDetailsToJson(RenewalFeeDetails instance) =>
    <String, dynamic>{
      'fee': instance.fee,
      'extra_fee': instance.extraFee,
      'joining_date': instance.joiningDate,
      'valid_from': instance.validFrom,
      'valid_to': instance.validTo,
      'status_code': instance.statusCode,
    };
