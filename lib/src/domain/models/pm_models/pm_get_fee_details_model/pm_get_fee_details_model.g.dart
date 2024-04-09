// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pm_get_fee_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PmGetFeeDetailsModel _$PmGetFeeDetailsModelFromJson(
        Map<String, dynamic> json) =>
    PmGetFeeDetailsModel(
      day: json['day'] as String?,
      joiningDate: json['joining_date'] as String?,
      planId: json['plan_id'] as String?,
      payType: json['pay_type'] as String?,
    );

Map<String, dynamic> _$PmGetFeeDetailsModelToJson(
        PmGetFeeDetailsModel instance) =>
    <String, dynamic>{
      'day': instance.day,
      'joining_date': instance.joiningDate,
      'plan_id': instance.planId,
      'pay_type': instance.payType,
    };
