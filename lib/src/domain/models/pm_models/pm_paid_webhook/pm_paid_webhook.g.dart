// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pm_paid_webhook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PmPaidWebhook _$PmPaidWebhookFromJson(Map<String, dynamic> json) =>
    PmPaidWebhook(
      sloteId: json['slote_id'] as int?,
      classDate: json['class_date'] as String?,
      paidAmount: json['paid_amount'] as num?,
      referenceId: json['reference_id'] as String?,
      transactionId: json['transaction_id'] as String?,
    );

Map<String, dynamic> _$PmPaidWebhookToJson(PmPaidWebhook instance) =>
    <String, dynamic>{
      'slote_id': instance.sloteId,
      'class_date': instance.classDate,
      'paid_amount': instance.paidAmount,
      'reference_id': instance.referenceId,
      'transaction_id': instance.transactionId,
    };
