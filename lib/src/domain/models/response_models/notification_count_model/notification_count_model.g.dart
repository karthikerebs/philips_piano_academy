// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_count_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationCountModel _$NotificationCountModelFromJson(
        Map<String, dynamic> json) =>
    NotificationCountModel(
      newNotifications: json['new_notifications'] as int?,
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$NotificationCountModelToJson(
        NotificationCountModel instance) =>
    <String, dynamic>{
      'new_notifications': instance.newNotifications,
      'status_code': instance.statusCode,
    };
