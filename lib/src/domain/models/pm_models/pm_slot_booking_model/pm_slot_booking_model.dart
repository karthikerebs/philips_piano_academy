import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pm_slot_booking_model.g.dart';

@JsonSerializable()
class PmSlotBookingModel extends Equatable {
  @JsonKey(name: 'slote_id')
  final String? sloteId;
  @JsonKey(name: 'plan_id')
  final String? planId;
  @JsonKey(name: 'pay_type')
  final String? payType;
  @JsonKey(name: 'joining_date')
  final String? joiningDate;
  @JsonKey(name: 'valid_from')
  final String? validFrom;
  @JsonKey(name: 'valid_to')
  final String? validTo;
  final String? fee;
  @JsonKey(name: 'extra_fee')
  final String? extraFee;
  final String? deposit;
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @JsonKey(name: 'paid_amount')
  final String? paidAmount;
  @JsonKey(name: 'reference_id')
  final String? referenceId;

  const PmSlotBookingModel({
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
    this.referenceId,
  });

  factory PmSlotBookingModel.fromJson(Map<String, dynamic> json) {
    return _$PmSlotBookingModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PmSlotBookingModelToJson(this);

  PmSlotBookingModel copyWith({
    String? sloteId,
    String? planId,
    String? payType,
    String? joiningDate,
    String? validFrom,
    String? validTo,
    String? fee,
    String? extraFee,
    String? deposit,
    String? paymentMethod,
    String? paidAmount,
    String? referenceId,
  }) {
    return PmSlotBookingModel(
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
      referenceId: referenceId ?? this.referenceId,
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
      referenceId,
    ];
  }
}
