// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptsModel _$ReceiptsModelFromJson(Map<String, dynamic> json) =>
    ReceiptsModel(
      receipts: (json['receipts'] as List<dynamic>?)
          ?.map((e) => Receipt.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$ReceiptsModelToJson(ReceiptsModel instance) =>
    <String, dynamic>{
      'receipts': instance.receipts,
      'status_code': instance.statusCode,
    };
