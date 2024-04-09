// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dates_and_available_slote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatesAndAvailableSlote _$DatesAndAvailableSloteFromJson(
        Map<String, dynamic> json) =>
    DatesAndAvailableSlote(
      date: json['date'] as String?,
      slotes: (json['slotes'] as List<dynamic>?)
          ?.map((e) => Slote.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DatesAndAvailableSloteToJson(
        DatesAndAvailableSlote instance) =>
    <String, dynamic>{
      'date': instance.date,
      'slotes': instance.slotes,
    };
