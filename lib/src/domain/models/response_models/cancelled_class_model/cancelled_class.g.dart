// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancelled_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelledClass _$CancelledClassFromJson(Map<String, dynamic> json) =>
    CancelledClass(
      id: json['id'] as int?,
      classDate: json['class_date'] as String?,
      studentId: json['student_id'] as int?,
      slote: json['slote'] as int?,
      reason: json['reason'] as String?,
      status: json['status'] as String?,
      rebookedStatus: json['rebooked_status'] as String?,
      rebookedBy: json['rebooked_by'],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$CancelledClassToJson(CancelledClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'class_date': instance.classDate,
      'student_id': instance.studentId,
      'slote': instance.slote,
      'reason': instance.reason,
      'status': instance.status,
      'rebooked_status': instance.rebookedStatus,
      'rebooked_by': instance.rebookedBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
