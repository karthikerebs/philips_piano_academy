import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'installment.g.dart';

@JsonSerializable()
class Installment extends Equatable {
  final int? id;
  @JsonKey(name: 'student_id')
  final int? studentId;
  @JsonKey(name: 'plan_id')
  final int? planId;
  @JsonKey(name: 'payment_date')
  final String? paymentDate;
  @JsonKey(name: 'last_date')
  final String? lastDate;
  @JsonKey(name: 'paid_amount')
  final String? paidAmount;
  final String? fee;
  @JsonKey(name: 'reference_id')
  final String? referenceId;
  @JsonKey(name: 'payment_status')
  final String? paymentStatus;
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @JsonKey(name: 'approval_status')
  final String? approvalStatus;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  const Installment({
    this.id,
    this.studentId,
    this.planId,
    this.paymentDate,
    this.lastDate,
    this.paidAmount,
    this.fee,
    this.referenceId,
    this.paymentStatus,
    this.paymentMethod,
    this.approvalStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory Installment.fromJson(Map<String, dynamic> json) {
    return _$InstallmentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InstallmentToJson(this);

  Installment copyWith({
    int? id,
    int? studentId,
    int? planId,
    String? paymentDate,
    String? lastDate,
    String? paidAmount,
    String? fee,
    String? referenceId,
    String? paymentStatus,
    String? paymentMethod,
    String? approvalStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Installment(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      planId: planId ?? this.planId,
      paymentDate: paymentDate ?? this.paymentDate,
      lastDate: lastDate ?? this.lastDate,
      paidAmount: paidAmount ?? this.paidAmount,
      fee: fee ?? this.fee,
      referenceId: referenceId ?? this.referenceId,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      studentId,
      planId,
      paymentDate,
      lastDate,
      paidAmount,
      fee,
      referenceId,
      paymentStatus,
      paymentMethod,
      approvalStatus,
      createdAt,
      updatedAt,
    ];
  }
}
