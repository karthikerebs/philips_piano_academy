// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pm_slote_book_webhook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PmSloteBookWebhook _$PmSloteBookWebhookFromJson(Map<String, dynamic> json) =>
    PmSloteBookWebhook(
      sloteId: json['slote_id'] as int?,
      planId: json['plan_id'] as int?,
      payType: json['pay_type'] as String?,
      joiningDate: json['joining_date'] as String?,
      validFrom: json['valid_from'] as String?,
      validTo: json['valid_to'] as String?,
      fee: json['fee'] as num?,
      extraFee: json['extra_fee'] as num?,
      deposit: json['deposit'] as num?,
      paymentMethod: json['payment_method'] as String?,
      paidAmount: json['paid_amount'] as num?,
      transactionId: json['transaction_id'] as String?,
    );

Map<String, dynamic> _$PmSloteBookWebhookToJson(PmSloteBookWebhook instance) =>
    <String, dynamic>{
      'slote_id': instance.sloteId,
      'plan_id': instance.planId,
      'pay_type': instance.payType,
      'joining_date': instance.joiningDate,
      'valid_from': instance.validFrom,
      'valid_to': instance.validTo,
      'fee': instance.fee,
      'extra_fee': instance.extraFee,
      'deposit': instance.deposit,
      'payment_method': instance.paymentMethod,
      'paid_amount': instance.paidAmount,
      'transaction_id': instance.transactionId,
    };
