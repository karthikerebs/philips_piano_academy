import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pm_send_renew_request_model.g.dart';

@JsonSerializable()
class PmSendRenewRequestModel extends Equatable {
  @JsonKey(name: 'months')
  final String? months;
  @JsonKey(name: 'pay_type')
  final String? payType;
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  final String? fee;
  @JsonKey(name: 'reference_id')
  final String? referenceId;
  @JsonKey(name: 'extra_fee')
  final String? extraFee;
  @JsonKey(name: 'joining_date')
  final String? joiningDate;
  @JsonKey(name: 'valid_from')
  final String? validFrom;
  @JsonKey(name: 'valid_to')
  final String? validTo;
  @JsonKey(name: 'extra_class_fee')
  final String? extraClassFee;

  const PmSendRenewRequestModel(
      {this.months,
      this.payType,
      this.paymentMethod,
      this.fee,
      this.referenceId,
      this.extraFee,
      this.joiningDate,
      this.validFrom,
      this.validTo,
      this.extraClassFee});

  factory PmSendRenewRequestModel.fromJson(Map<String, dynamic> json) {
    return _$PmSendRenewRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PmSendRenewRequestModelToJson(this);

  PmSendRenewRequestModel copyWith(
      {String? months,
      String? payType,
      String? paymentMethod,
      String? fee,
      String? referenceId,
      String? extraFee,
      String? joiningDate,
      String? validFrom,
      String? validTo,
      String? extraClassFee}) {
    return PmSendRenewRequestModel(
        months: months ?? this.months,
        payType: payType ?? this.payType,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        fee: fee ?? this.fee,
        referenceId: referenceId ?? this.referenceId,
        extraFee: extraFee ?? this.extraFee,
        joiningDate: joiningDate ?? this.joiningDate,
        validFrom: validFrom ?? this.validFrom,
        validTo: validTo ?? this.validTo,
        extraClassFee: extraClassFee ?? this.extraClassFee);
  }

  @override
  List<Object?> get props {
    return [
      months,
      payType,
      paymentMethod,
      fee,
      referenceId,
      extraFee,
      joiningDate,
      validFrom,
      validTo,
      extraClassFee
    ];
  }
}
