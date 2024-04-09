import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pm_get_fee_details_model.g.dart';

@JsonSerializable()
class PmGetFeeDetailsModel extends Equatable {
  final String? day;
  @JsonKey(name: 'joining_date')
  final String? joiningDate;
  @JsonKey(name: 'plan_id')
  final String? planId;
  @JsonKey(name: 'pay_type')
  final String? payType;

  const PmGetFeeDetailsModel({
    this.day,
    this.joiningDate,
    this.planId,
    this.payType,
  });

  factory PmGetFeeDetailsModel.fromJson(Map<String, dynamic> json) {
    return _$PmGetFeeDetailsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PmGetFeeDetailsModelToJson(this);

  PmGetFeeDetailsModel copyWith({
    String? day,
    String? joiningDate,
    String? planId,
    String? payType,
  }) {
    return PmGetFeeDetailsModel(
      day: day ?? this.day,
      joiningDate: joiningDate ?? this.joiningDate,
      planId: planId ?? this.planId,
      payType: payType ?? this.payType,
    );
  }

  @override
  List<Object?> get props => [day, joiningDate, planId, payType];
}
