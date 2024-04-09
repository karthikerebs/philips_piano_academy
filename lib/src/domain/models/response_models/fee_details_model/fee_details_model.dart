import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fee_details_model.g.dart';

@JsonSerializable()
class FeeDetailsModel extends Equatable {
  final num? fee;
  @JsonKey(name: 'extra_fee')
  final num? extraFee;
  final String? deposit;
  @JsonKey(name: 'joining_date')
  final String? joiningDate;
  @JsonKey(name: 'valid_from')
  final String? validFrom;
  @JsonKey(name: 'valid_to')
  final String? validTo;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const FeeDetailsModel({
    this.fee,
    this.extraFee,
    this.deposit,
    this.joiningDate,
    this.validFrom,
    this.validTo,
    this.statusCode,
  });

  factory FeeDetailsModel.fromJson(Map<String, dynamic> json) {
    return _$FeeDetailsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FeeDetailsModelToJson(this);

  FeeDetailsModel copyWith({
    num? fee,
    num? extraFee,
    String? deposit,
    String? joiningDate,
    String? validFrom,
    String? validTo,
    String? statusCode,
  }) {
    return FeeDetailsModel(
      fee: fee ?? this.fee,
      extraFee: extraFee ?? this.extraFee,
      deposit: deposit ?? this.deposit,
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
      deposit,
      joiningDate,
      validFrom,
      validTo,
      statusCode,
    ];
  }
}
