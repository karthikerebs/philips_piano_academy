// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paid_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaidClass _$PaidClassFromJson(Map<String, dynamic> json) => PaidClass(
      id: json['id'] as int?,
      studentId: json['student_id'] as int?,
      details: json['details'],
      note: json['note'],
      status: json['status'] as String?,
      cancelReason: json['cancel_reason'],
      slote: json['slote'] as int?,
      bookedDate: json['booked_date'] as String?,
      attendance: json['attendance'] as String?,
      type: json['type'] as String?,
      paidAmount: json['paid_amount'] as String?,
      paymentMethod: json['payment_method'] as String?,
      paymentDate: json['payment_date'] as String?,
      referenceId: json['reference_id'],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      addedBy: json['added_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      sloteTime: json['slote_time'] as String?,
    );

Map<String, dynamic> _$PaidClassToJson(PaidClass instance) => <String, dynamic>{
      'id': instance.id,
      'student_id': instance.studentId,
      'details': instance.details,
      'note': instance.note,
      'status': instance.status,
      'cancel_reason': instance.cancelReason,
      'slote': instance.slote,
      'booked_date': instance.bookedDate,
      'attendance': instance.attendance,
      'type': instance.type,
      'paid_amount': instance.paidAmount,
      'payment_method': instance.paymentMethod,
      'payment_date': instance.paymentDate,
      'reference_id': instance.referenceId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'added_by': instance.addedBy,
      'updated_by': instance.updatedBy,
      'slote_time': instance.sloteTime,
    };
