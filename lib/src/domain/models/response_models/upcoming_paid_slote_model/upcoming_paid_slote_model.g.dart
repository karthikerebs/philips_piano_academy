// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_paid_slote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpcomingPaidSloteModel _$UpcomingPaidSloteModelFromJson(
        Map<String, dynamic> json) =>
    UpcomingPaidSloteModel(
      fee: json['fee'] as String?,
      datesAndAvailableSlotes: (json['dates_and_available_slotes']
              as List<dynamic>?)
          ?.map(
              (e) => DatesAndAvailableSlote.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$UpcomingPaidSloteModelToJson(
        UpcomingPaidSloteModel instance) =>
    <String, dynamic>{
      'fee': instance.fee,
      'dates_and_available_slotes': instance.datesAndAvailableSlotes,
      'status_code': instance.statusCode,
    };
