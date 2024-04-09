// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpcomingClass _$UpcomingClassFromJson(Map<String, dynamic> json) =>
    UpcomingClass(
      month: json['month'] as String?,
      dates: (json['dates'] as List<dynamic>?)
          ?.map((e) => Date.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpcomingClassToJson(UpcomingClass instance) =>
    <String, dynamic>{
      'month': instance.month,
      'dates': instance.dates,
    };
