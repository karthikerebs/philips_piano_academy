// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Receipt _$ReceiptFromJson(Map<String, dynamic> json) => Receipt(
      id: json['id'] as int?,
      type: json['type'] as String?,
      fee: json['fee'] as int?,
      extraFee: json['extra_fee'],
      extraClassFee: json['extra_class_fee'],
      paymentDate: json['payment_date'] as String?,
      student: json['student'] as int?,
      deposit: json['deposit'],
      status: json['status'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ReceiptToJson(Receipt instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'fee': instance.fee,
      'extra_fee': instance.extraFee,
      'extra_class_fee': instance.extraClassFee,
      'payment_date': instance.paymentDate,
      'student': instance.student,
      'deposit': instance.deposit,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
