import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'renewal_fee_details.g.dart';

@JsonSerializable()
class RenewalFeeDetails extends Equatable {
  final num? fee;
  @JsonKey(name: 'extra_fee')
  final num? extraFee;
  @JsonKey(name: 'joining_date')
  final String? joiningDate;
  @JsonKey(name: 'valid_from')
  final String? validFrom;
  @JsonKey(name: 'valid_to')
  final String? validTo;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const RenewalFeeDetails({
    this.fee,
    this.extraFee,
    this.joiningDate,
    this.validFrom,
    this.validTo,
    this.statusCode,
  });

  factory RenewalFeeDetails.fromJson(Map<String, dynamic> json) {
    return _$RenewalFeeDetailsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RenewalFeeDetailsToJson(this);

  RenewalFeeDetails copyWith({
    num? fee,
    num? extraFee,
    String? joiningDate,
    String? validFrom,
    String? validTo,
    String? statusCode,
  }) {
    return RenewalFeeDetails(
      fee: fee ?? this.fee,
      extraFee: extraFee ?? this.extraFee,
      joiningDate: joiningDate ?? this.joiningDate,
      validFrom: validFrom ?? this.validFrom,
      validTo: validTo ?? this.validTo,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props {
    return [
      fee,
      extraFee,
      joiningDate,
      validFrom,
      validTo,
      statusCode,
    ];
  }
}
