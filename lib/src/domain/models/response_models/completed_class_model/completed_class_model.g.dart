// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_class_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletedClassModel _$CompletedClassModelFromJson(Map<String, dynamic> json) =>
    CompletedClassModel(
      completedClasses: (json['completed_classes'] as List<dynamic>?)
          ?.map((e) => CompletedClass.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$CompletedClassModelToJson(
        CompletedClassModel instance) =>
    <String, dynamic>{
      'completed_classes': instance.completedClasses,
      'status_code': instance.statusCode,
    };
