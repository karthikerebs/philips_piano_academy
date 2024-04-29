// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pm_renewal_webhook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PmRenewalWebhook _$PmRenewalWebhookFromJson(Map<String, dynamic> json) =>
    PmRenewalWebhook(
      months: json['months'] as int?,
      payType: json['pay_type'] as String?,
      joiningDate: json['joining_date'] as String?,
      validFrom: json['valid_from'] as String?,
      validTo: json['valid_to'] as String?,
      fee: json['fee'] as num?,
      extraFee: json['extra_fee'] as num?,
      extraClassFee: json['extra_class_fee'] as num?,
      paymentMethod: json['payment_method'] as String?,
      transactionId: json['transaction_id'] as String?,
    );

Map<String, dynamic> _$PmRenewalWebhookToJson(PmRenewalWebhook instance) =>
    <String, dynamic>{
      'months': instance.months,
      'pay_type': instance.payType,
      'joining_date': instance.joiningDate,
      'valid_from': instance.validFrom,
      'valid_to': instance.validTo,
      'fee': instance.fee,
      'extra_fee': instance.extraFee,
      'extra_class_fee': instance.extraClassFee,
      'payment_method': instance.paymentMethod,
      'transaction_id': instance.transactionId,
    };
