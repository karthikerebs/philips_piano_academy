import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'refund_request.dart';

part 'refund_request_model.g.dart';

@JsonSerializable()
class RefundRequestModel extends Equatable {
  @JsonKey(name: 'refund_requests')
  final List<RefundRequest>? refundRequests;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const RefundRequestModel({this.refundRequests, this.statusCode});

  factory RefundRequestModel.fromJson(Map<String, dynamic> json) {
    return _$RefundRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RefundRequestModelToJson(this);

  RefundRequestModel copyWith({
    List<RefundRequest>? refundRequests,
    String? statusCode,
  }) {
    return RefundRequestModel(
      refundRequests: refundRequests ?? this.refundRequests,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [refundRequests, statusCode];
}
