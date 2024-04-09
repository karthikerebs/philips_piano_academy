// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstallmentModel _$InstallmentModelFromJson(Map<String, dynamic> json) =>
    InstallmentModel(
      installments: (json['installments'] as List<dynamic>?)
          ?.map((e) => Installment.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$InstallmentModelToJson(InstallmentModel instance) =>
    <String, dynamic>{
      'installments': instance.installments,
      'status_code': instance.statusCode,
    };
