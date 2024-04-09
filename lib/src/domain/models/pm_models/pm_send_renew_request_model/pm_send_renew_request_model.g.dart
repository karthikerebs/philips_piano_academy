// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pm_send_renew_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PmSendRenewRequestModel _$PmSendRenewRequestModelFromJson(
        Map<String, dynamic> json) =>
    PmSendRenewRequestModel(
      months: json['months'] as String?,
      payType: json['pay_type'] as String?,
      paymentMethod: json['payment_method'] as String?,
      fee: json['fee'] as String?,
      referenceId: json['reference_id'] as String?,
      extraFee: json['extra_fee'] as String?,
      joiningDate: json['joining_date'] as String?,
      validFrom: json['valid_from'] as String?,
      validTo: json['valid_to'] as String?,
      extraClassFee: json['extra_class_fee'] as String?,
    );

Map<String, dynamic> _$PmSendRenewRequestModelToJson(
        PmSendRenewRequestModel instance) =>
    <String, dynamic>{
      'months': instance.months,
      'pay_type': instance.payType,
      'payment_method': instance.paymentMethod,
      'fee': instance.fee,
      'reference_id': instance.referenceId,
      'extra_fee': instance.extraFee,
      'joining_date': instance.joiningDate,
      'valid_from': instance.validFrom,
      'valid_to': instance.validTo,
      'extra_class_fee': instance.extraClassFee,
    };
