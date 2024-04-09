// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paid_class_slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaidClassSlotModel _$PaidClassSlotModelFromJson(Map<String, dynamic> json) =>
    PaidClassSlotModel(
      fee: json['fee'] as String?,
      slotes: (json['slotes'] as List<dynamic>?)
          ?.map((e) => Slote.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$PaidClassSlotModelToJson(PaidClassSlotModel instance) =>
    <String, dynamic>{
      'fee': instance.fee,
      'slotes': instance.slotes,
      'status_code': instance.statusCode,
    };
