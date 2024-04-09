// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plans_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlansModel _$PlansModelFromJson(Map<String, dynamic> json) => PlansModel(
      plans: (json['plans'] as List<dynamic>?)
          ?.map((e) => Plan.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$PlansModelToJson(PlansModel instance) =>
    <String, dynamic>{
      'plans': instance.plans,
      'status_code': instance.statusCode,
    };
