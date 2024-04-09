import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'plan.dart';

part 'plans_model.g.dart';

@JsonSerializable()
class PlansModel extends Equatable {
  final List<Plan>? plans;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const PlansModel({this.plans, this.statusCode});

  factory PlansModel.fromJson(Map<String, dynamic> json) {
    return _$PlansModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PlansModelToJson(this);

  PlansModel copyWith({
    List<Plan>? plans,
    String? statusCode,
  }) {
    return PlansModel(
      plans: plans ?? this.plans,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [plans, statusCode];
}
