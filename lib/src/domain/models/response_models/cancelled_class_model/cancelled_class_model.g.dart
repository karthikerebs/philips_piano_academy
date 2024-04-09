// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancelled_class_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelledClassModel _$CancelledClassModelFromJson(Map<String, dynamic> json) =>
    CancelledClassModel(
      cancelledClasses: (json['cancelled_classes'] as List<dynamic>?)
          ?.map((e) => CancelledClass.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$CancelledClassModelToJson(
        CancelledClassModel instance) =>
    <String, dynamic>{
      'cancelled_classes': instance.cancelledClasses,
      'status_code': instance.statusCode,
    };
