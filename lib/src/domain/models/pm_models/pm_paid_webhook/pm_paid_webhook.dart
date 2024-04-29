import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'pm_paid_webhook.g.dart';

@JsonSerializable()
class PmPaidWebhook extends Equatable {
  @JsonKey(name: 'slote_id')
  final int? sloteId;

  @JsonKey(name: 'class_date')
  final String? classDate;

  @JsonKey(name: 'paid_amount')
  final num? paidAmount;

  @JsonKey(name: 'reference_id')
  final String? referenceId;

  @JsonKey(name: 'transaction_id')
  final String? transactionId;

  const PmPaidWebhook({
    this.sloteId,
    this.classDate,
    this.paidAmount,
    this.referenceId,
    this.transactionId,
  });

  factory PmPaidWebhook.fromJson(Map<String, dynamic> json) {
    return _$PmPaidWebhookFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PmPaidWebhookToJson(this);

  PmPaidWebhook copyWith({
    int? sloteId,
    String? classDate,
    num? paidAmount,
    String? referenceId,
    String? transactionId,
  }) {
    return PmPaidWebhook(
      sloteId: sloteId ?? this.sloteId,
      classDate: classDate ?? this.classDate,
      paidAmount: paidAmount ?? this.paidAmount,
      referenceId: referenceId ?? this.referenceId,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  @override
  List<Object?> get props {
    return [
      sloteId,
      classDate,
      paidAmount,
      referenceId,
      transactionId,
    ];
  }
}
