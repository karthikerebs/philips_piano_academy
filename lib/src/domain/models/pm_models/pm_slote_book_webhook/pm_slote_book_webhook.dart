import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'pm_slote_book_webhook.g.dart';

@JsonSerializable()
class PmSloteBookWebhook extends Equatable {
  @JsonKey(name: 'slote_id')
  final int? sloteId;

  @JsonKey(name: 'plan_id')
  final int? planId;

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

  final num? deposit;

  @JsonKey(name: 'payment_method')
  final String? paymentMethod;

  @JsonKey(name: 'paid_amount')
  final num? paidAmount;

  @JsonKey(name: 'transaction_id')
  final String? transactionId;

  const PmSloteBookWebhook({
    this.sloteId,
    this.planId,
    this.payType,
    this.joiningDate,
    this.validFrom,
    this.validTo,
    this.fee,
    this.extraFee,
    this.deposit,
    this.paymentMethod,
    this.paidAmount,
    this.transactionId,
  });

  factory PmSloteBookWebhook.fromJson(Map<String, dynamic> json) {
    return _$PmSloteBookWebhookFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PmSloteBookWebhookToJson(this);

  PmSloteBookWebhook copyWith({
    int? sloteId,
    int? planId,
    String? payType,
    String? joiningDate,
    String? validFrom,
    String? validTo,
    num? fee,
    num? extraFee,
    num? deposit,
    String? paymentMethod,
    num? paidAmount,
    String? transactionId,
  }) {
    return PmSloteBookWebhook(
      sloteId: sloteId ?? this.sloteId,
      planId: planId ?? this.planId,
      payType: payType ?? this.payType,
      joiningDate: joiningDate ?? this.joiningDate,
      validFrom: validFrom ?? this.validFrom,
      validTo: validTo ?? this.validTo,
      fee: fee ?? this.fee,
      extraFee: extraFee ?? this.extraFee,
      deposit: deposit ?? this.deposit,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paidAmount: paidAmount ?? this.paidAmount,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  @override
  List<Object?> get props {
    return [
      sloteId,
      planId,
      payType,
      joiningDate,
      validFrom,
      validTo,
      fee,
      extraFee,
      deposit,
      paymentMethod,
      paidAmount,
      transactionId,
    ];
  }
}
