// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_installment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentInstallmentModel _$PaymentInstallmentModelFromJson(
        Map<String, dynamic> json) =>
    PaymentInstallmentModel(
      installments: (json['installments'] as List<dynamic>?)
          ?.map((e) => PaymentInstallment.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$PaymentInstallmentModelToJson(
        PaymentInstallmentModel instance) =>
    <String, dynamic>{
      'installments': instance.installments,
      'status_code': instance.statusCode,
    };
