// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Slote _$SloteFromJson(Map<String, dynamic> json) => Slote(
      id: json['id'] as int?,
      classMode: json['class_mode'] as String?,
      branch: json['branch'] as int?,
      day: json['day'] as String?,
      slote: json['slote'] as String?,
      sloteLimit: json['slote_limit'] as int?,
      status: json['status'] as String?,
      availability: json['availability'] as String?,
    );

Map<String, dynamic> _$SloteToJson(Slote instance) => <String, dynamic>{
      'id': instance.id,
      'class_mode': instance.classMode,
      'branch': instance.branch,
      'day': instance.day,
      'slote': instance.slote,
      'slote_limit': instance.sloteLimit,
      'status': instance.status,
      'availability': instance.availability,
    };
