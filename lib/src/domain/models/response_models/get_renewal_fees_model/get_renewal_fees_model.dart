import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_renewal_fees_model.g.dart';

@JsonSerializable()
class GetRenewalFeesModel extends Equatable {
  @JsonKey(name: 'renewal_fee')
  final num? renewalFee;
  @JsonKey(name: 'extra_class_fee')
  final num? extraClassFee;
  @JsonKey(name: 'status_code')
  final String? statusCode;
  @JsonKey(name: 'extra_class')
  final num? extraClass;

  const GetRenewalFeesModel(
      {this.renewalFee, this.extraClassFee, this.statusCode, this.extraClass});

  factory GetRenewalFeesModel.fromJson(Map<String, dynamic> json) {
    return _$GetRenewalFeesModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetRenewalFeesModelToJson(this);

  GetRenewalFeesModel copyWith(
      {num? renewalFee,
      num? extraClassFee,
      String? statusCode,
      num? extraClass}) {
    return GetRenewalFeesModel(
        renewalFee: renewalFee ?? this.renewalFee,
        extraClassFee: extraClassFee ?? this.extraClassFee,
        statusCode: statusCode ?? this.statusCode,
        extraClass: extraClass ?? this.extraClass);
  }

  @override
  List<Object?> get props =>
      [renewalFee, extraClassFee, statusCode, extraClass];
}
