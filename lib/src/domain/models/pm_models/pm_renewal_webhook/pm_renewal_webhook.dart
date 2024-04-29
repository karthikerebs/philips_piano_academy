import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'pm_renewal_webhook.g.dart';

@JsonSerializable()
class PmRenewalWebhook extends Equatable {
  final int? months;

  @JsonKey(name: 'pay_type')
  final String? payType;

  @JsonKey(name: 'joining_date')
  final String? joiningDate;

  @JsonKey(name: 'valid_from')
  final String? validFrom;

  @JsonKey(name: 'valid_to')
  final String? validTo;

  final num? fee;

  @JsonKey(name: 'extra_fee')
  final num? extraFee;

  @JsonKey(name: 'extra_class_fee')
  final num? extraClassFee;

  @JsonKey(name: 'payment_method')
  final String? paymentMethod;

  @JsonKey(name: 'transaction_id')
  final String? transactionId;

  const PmRenewalWebhook({
    this.months,
    this.payType,
    this.joiningDate,
    this.validFrom,
    this.validTo,
    this.fee,
    this.extraFee,
    this.extraClassFee,
    this.paymentMethod,
    this.transactionId,
  });

  factory PmRenewalWebhook.fromJson(Map<String, dynamic> json) {
    return _$PmRenewalWebhookFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PmRenewalWebhookToJson(this);

  PmRenewalWebhook copyWith({
    int? months,
    String? payType,
    String? joiningDate,
    String? validFrom,
    String? validTo,
    num? fee,
    num? extraFee,
    num? extraClassFee,
    String? paymentMethod,
    String? transactionId,
  }) {
    return PmRenewalWebhook(
      months: months ?? this.months,
      payType: payType ?? this.payType,
      joiningDate: joiningDate ?? this.joiningDate,
      validFrom: validFrom ?? this.validFrom,
      validTo: validTo ?? this.validTo,
      fee: fee ?? this.fee,
      extraFee: extraFee ?? this.extraFee,
      extraClassFee: extraClassFee ?? this.extraClassFee,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  @override
  List<Object?> get props {
    return [
      months,
      payType,
      joiningDate,
      validFrom,
      validTo,
      fee,
      extraFee,
      extraClassFee,
      paymentMethod,
      transactionId,
    ];
  }
}
