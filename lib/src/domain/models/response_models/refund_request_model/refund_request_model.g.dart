// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefundRequestModel _$RefundRequestModelFromJson(Map<String, dynamic> json) =>
    RefundRequestModel(
      refundRequests: (json['refund_requests'] as List<dynamic>?)
          ?.map((e) => RefundRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$RefundRequestModelToJson(RefundRequestModel instance) =>
    <String, dynamic>{
      'refund_requests': instance.refundRequests,
      'status_code': instance.statusCode,
    };
