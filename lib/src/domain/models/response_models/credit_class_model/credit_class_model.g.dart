// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_class_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditClassModel _$CreditClassModelFromJson(Map<String, dynamic> json) =>
    CreditClassModel(
      creditClasses: (json['credit_classes'] as List<dynamic>?)
          ?.map((e) => CreditClass.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$CreditClassModelToJson(CreditClassModel instance) =>
    <String, dynamic>{
      'credit_classes': instance.creditClasses,
      'status_code': instance.statusCode,
    };
