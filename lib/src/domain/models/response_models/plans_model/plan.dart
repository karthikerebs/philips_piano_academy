import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plan.g.dart';

@JsonSerializable()
class Plan extends Equatable {
  final int? id;
  final String? name;
  @JsonKey(name: 'class_mode')
  final String? classMode;
  final int? month;
  @JsonKey(name: 'actual_fee')
  final num? actualFee;
  @JsonKey(name: 'offer_fee')
  final num? offerFee;
  @JsonKey(name: 'monthly_fee')
  final num? monthlyFee;
  final String? status;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  const Plan({
    this.id,
    this.name,
    this.classMode,
    this.month,
    this.actualFee,
    this.offerFee,
    this.monthlyFee,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

  Map<String, dynamic> toJson() => _$PlanToJson(this);

  Plan copyWith({
    int? id,
    String? name,
    String? classMode,
    int? month,
    num? actualFee,
    num? offerFee,
    num? monthlyFee,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Plan(
      id: id ?? this.id,
      name: name ?? this.name,
      classMode: classMode ?? this.classMode,
      month: month ?? this.month,
      actualFee: actualFee ?? this.actualFee,
      offerFee: offerFee ?? this.offerFee,
      monthlyFee: monthlyFee ?? this.monthlyFee,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      classMode,
      month,
      actualFee,
      offerFee,
      monthlyFee,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
