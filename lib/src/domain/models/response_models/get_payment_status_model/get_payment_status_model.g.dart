// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_payment_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPaymentStatusModel _$GetPaymentStatusModelFromJson(
        Map<String, dynamic> json) =>
    GetPaymentStatusModel(
      onlinepayStatus: json['onlinepay_status'] as String?,
    );

Map<String, dynamic> _$GetPaymentStatusModelToJson(
        GetPaymentStatusModel instance) =>
    <String, dynamic>{
      'onlinepay_status': instance.onlinepayStatus,
    };
