// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditClass _$CreditClassFromJson(Map<String, dynamic> json) => CreditClass(
      id: json['id'] as int?,
      status: json['status'] as String?,
      bookedDate: json['booked_date'],
      dueDate: json['due_date'] as String?,
      attendance: json['attendance'] as String?,
      sloteTime: json['slote_time'],
      bookStatus: json['book_status'] as bool?,
      cancelStatus: json['cancel_status'] as bool?,
      emergencyCancel: json['emergency_cancel'] as bool?,
      details: json['details'] as String?,
      addedBy: json['added_by'] as String?,
    );

Map<String, dynamic> _$CreditClassToJson(CreditClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'booked_date': instance.bookedDate,
      'due_date': instance.dueDate,
      'attendance': instance.attendance,
      'slote_time': instance.sloteTime,
      'book_status': instance.bookStatus,
      'cancel_status': instance.cancelStatus,
      'emergency_cancel': instance.emergencyCancel,
      'details': instance.details,
      'added_by': instance.addedBy,
    };
