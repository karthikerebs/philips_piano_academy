import 'package:json_annotation/json_annotation.dart';

part 'installment.g.dart';

@JsonSerializable()
class PaymentInstallment {
  int? id;
  @JsonKey(name: 'student_id')
  int? studentId;
  @JsonKey(name: 'plan_id')
  int? planId;
  @JsonKey(name: 'payment_date')
  dynamic paymentDate;
  @JsonKey(name: 'last_date')
  String? lastDate;
  @JsonKey(name: 'paid_amount')
  dynamic paidAmount;
  String? fee;
  @JsonKey(name: 'reference_id')
  dynamic referenceId;
  @JsonKey(name: 'payment_status')
  String? paymentStatus;
  @JsonKey(name: 'payment_method')
  String? paymentMethod;
  @JsonKey(name: 'approval_status')
  String? approvalStatus;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  PaymentInstallment({
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

  factory PaymentInstallment.fromJson(Map<String, dynamic> json) {
    return _$PaymentInstallmentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaymentInstallmentToJson(this);

  PaymentInstallment copyWith({
    int? id,
    int? studentId,
    int? planId,
    dynamic paymentDate,
    String? lastDate,
    dynamic paidAmount,
    String? fee,
    dynamic referenceId,
    String? paymentStatus,
    String? paymentMethod,
    String? approvalStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PaymentInstallment(
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
}
