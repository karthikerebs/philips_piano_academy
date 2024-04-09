// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Date _$DateFromJson(Map<String, dynamic> json) => Date(
      date: json['date'] as String?,
      slote: json['slote'] as String?,
      status: json['status'] as String?,
      cancelStatus: json['cancel_status'] as bool?,
      emergencyCancel: json['emergency_cancel'] as bool?,
    );

Map<String, dynamic> _$DateToJson(Date instance) => <String, dynamic>{
      'date': instance.date,
      'slote': instance.slote,
      'status': instance.status,
      'cancel_status': instance.cancelStatus,
      'emergency_cancel': instance.emergencyCancel,
    };
