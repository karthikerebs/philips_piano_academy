// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'piad_class_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PiadClassModel _$PiadClassModelFromJson(Map<String, dynamic> json) =>
    PiadClassModel(
      paidClasses: (json['paid_classes'] as List<dynamic>?)
          ?.map((e) => PaidClass.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$PiadClassModelToJson(PiadClassModel instance) =>
    <String, dynamic>{
      'paid_classes': instance.paidClasses,
      'status_code': instance.statusCode,
    };
