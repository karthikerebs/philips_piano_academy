// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plan _$PlanFromJson(Map<String, dynamic> json) => Plan(
      id: json['id'] as int?,
      name: json['name'] as String?,
      classMode: json['class_mode'] as String?,
      month: json['month'] as int?,
      actualFee: json['actual_fee'] as num?,
      offerFee: json['offer_fee'] as num?,
      monthlyFee: json['monthly_fee'] as num?,
      status: json['status'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'class_mode': instance.classMode,
      'month': instance.month,
      'actual_fee': instance.actualFee,
      'offer_fee': instance.offerFee,
      'monthly_fee': instance.monthlyFee,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
