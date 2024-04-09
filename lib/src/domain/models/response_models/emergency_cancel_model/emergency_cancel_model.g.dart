// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_cancel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyCancelModel _$EmergencyCancelModelFromJson(
        Map<String, dynamic> json) =>
    EmergencyCancelModel(
      message: json['message'] as String?,
      emergencyCancelPrnding: json['emergency_cancel_prnding'] as int?,
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$EmergencyCancelModelToJson(
        EmergencyCancelModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'emergency_cancel_prnding': instance.emergencyCancelPrnding,
      'status_code': instance.statusCode,
    };
