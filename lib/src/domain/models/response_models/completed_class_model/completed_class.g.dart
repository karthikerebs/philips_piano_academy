// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletedClass _$CompletedClassFromJson(Map<String, dynamic> json) =>
    CompletedClass(
      id: json['id'] as int?,
      atDate: json['at_date'] as String?,
      studentId: json['student_id'] as int?,
      slote: json['slote'] as int?,
      note: json['note'],
      status: json['status'] as String?,
      addedBy: json['added_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      extraStatus: json['extra_status'] as bool?,
    );

Map<String, dynamic> _$CompletedClassToJson(CompletedClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'at_date': instance.atDate,
      'student_id': instance.studentId,
      'slote': instance.slote,
      'note': instance.note,
      'status': instance.status,
      'added_by': instance.addedBy,
      'updated_by': instance.updatedBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'extra_status': instance.extraStatus,
    };
