import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'slote.dart';

part 'paid_class_slot_model.g.dart';

@JsonSerializable()
class PaidClassSlotModel extends Equatable {
  final String? fee;
  final List<Slote>? slotes;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const PaidClassSlotModel({this.fee, this.slotes, this.statusCode});

  factory PaidClassSlotModel.fromJson(Map<String, dynamic> json) {
    return _$PaidClassSlotModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaidClassSlotModelToJson(this);

  PaidClassSlotModel copyWith({
    String? fee,
    List<Slote>? slotes,
    String? statusCode,
  }) {
    return PaidClassSlotModel(
      fee: fee ?? this.fee,
      slotes: slotes ?? this.slotes,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [fee, slotes, statusCode];
}
