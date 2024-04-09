// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_slotes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpcomingSlotesModel _$UpcomingSlotesModelFromJson(Map<String, dynamic> json) =>
    UpcomingSlotesModel(
      datesAndAvailableSlotes: (json['dates_and_available_slotes']
              as List<dynamic>?)
          ?.map(
              (e) => DatesAndAvailableSlote.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$UpcomingSlotesModelToJson(
        UpcomingSlotesModel instance) =>
    <String, dynamic>{
      'dates_and_available_slotes': instance.datesAndAvailableSlotes,
      'status_code': instance.statusCode,
    };
