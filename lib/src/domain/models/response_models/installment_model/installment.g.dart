// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Installment _$InstallmentFromJson(Map<String, dynamic> json) => Installment(
      id: json['id'] as int?,
      studentId: json['student_id'] as int?,
      planId: json['plan_id'] as int?,
      paymentDate: json['payment_date'] as String?,
      lastDate: json['last_date'] as String?,
      paidAmount: json['paid_amount'] as String?,
      fee: json['fee'] as String?,
      referenceId: json['reference_id'] as String?,
      paymentStatus: json['payment_status'] as String?,
      paymentMethod: json['payment_method'] as String?,
      approvalStatus: json['approval_status'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$InstallmentToJson(Installment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'student_id': instance.studentId,
      'plan_id': instance.planId,
      'payment_date': instance.paymentDate,
      'last_date': instance.lastDate,
      'paid_amount': instance.paidAmount,
      'fee': instance.fee,
      'reference_id': instance.referenceId,
      'payment_status': instance.paymentStatus,
      'payment_method': instance.paymentMethod,
      'approval_status': instance.approvalStatus,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
