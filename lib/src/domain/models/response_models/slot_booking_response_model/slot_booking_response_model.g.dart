// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot_booking_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlotBookingResponseModel _$SlotBookingResponseModelFromJson(
        Map<String, dynamic> json) =>
    SlotBookingResponseModel(
      message: json['message'] as String?,
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$SlotBookingResponseModelToJson(
        SlotBookingResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status_code': instance.statusCode,
    };
