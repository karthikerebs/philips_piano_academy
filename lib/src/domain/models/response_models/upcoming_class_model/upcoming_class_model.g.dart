// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_class_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpcomingClassModel _$UpcomingClassModelFromJson(Map<String, dynamic> json) =>
    UpcomingClassModel(
      upcomingClasses: (json['upcoming_classes'] as List<dynamic>?)
          ?.map((e) => UpcomingClass.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$UpcomingClassModelToJson(UpcomingClassModel instance) =>
    <String, dynamic>{
      'upcoming_classes': instance.upcomingClasses,
      'status_code': instance.statusCode,
    };
