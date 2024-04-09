// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlotModel _$SlotModelFromJson(Map<String, dynamic> json) => SlotModel(
      slotes: (json['slotes'] as List<dynamic>?)
          ?.map((e) => Slote.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$SlotModelToJson(SlotModel instance) => <String, dynamic>{
      'slotes': instance.slotes,
      'status_code': instance.statusCode,
    };
