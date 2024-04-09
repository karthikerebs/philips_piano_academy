import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paid_class.g.dart';

@JsonSerializable()
class PaidClass extends Equatable {
  final int? id;
  @JsonKey(name: 'student_id')
  final int? studentId;
  final dynamic details;
  final dynamic note;
  final String? status;
  @JsonKey(name: 'cancel_reason')
  final dynamic cancelReason;
  final int? slote;
  @JsonKey(name: 'booked_date')
  final String? bookedDate;
  final String? attendance;
  final String? type;
  @JsonKey(name: 'paid_amount')
  final String? paidAmount;
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @JsonKey(name: 'payment_date')
  final String? paymentDate;
  @JsonKey(name: 'reference_id')
  final dynamic referenceId;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'added_by')
  final String? addedBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'slote_time')
  final String? sloteTime;

  const PaidClass(
      {this.id,
      this.studentId,
      this.details,
      this.note,
      this.status,
      this.cancelReason,
      this.slote,
      this.bookedDate,
      this.attendance,
      this.type,
      this.paidAmount,
      this.paymentMethod,
      this.paymentDate,
      this.referenceId,
      this.createdAt,
      this.updatedAt,
      this.addedBy,
      this.updatedBy,
      this.sloteTime});

  factory PaidClass.fromJson(Map<String, dynamic> json) {
    return _$PaidClassFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaidClassToJson(this);

  PaidClass copyWith(
      {int? id,
      int? studentId,
      dynamic details,
      dynamic note,
      String? status,
      dynamic cancelReason,
      int? slote,
      String? bookedDate,
      String? attendance,
      String? type,
      String? paidAmount,
      String? paymentMethod,
      String? paymentDate,
      dynamic referenceId,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? addedBy,
      String? updatedBy,
      String? sloteTime}) {
    return PaidClass(
        id: id ?? this.id,
        studentId: studentId ?? this.studentId,
        details: details ?? this.details,
        note: note ?? this.note,
        status: status ?? this.status,
        cancelReason: cancelReason ?? this.cancelReason,
        slote: slote ?? this.slote,
        bookedDate: bookedDate ?? this.bookedDate,
        attendance: attendance ?? this.attendance,
        type: type ?? this.type,
        paidAmount: paidAmount ?? this.paidAmount,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        paymentDate: paymentDate ?? this.paymentDate,
        referenceId: referenceId ?? this.referenceId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        addedBy: addedBy ?? this.addedBy,
        updatedBy: updatedBy ?? this.updatedBy,
        sloteTime: sloteTime ?? this.sloteTime);
  }

  @override
  List<Object?> get props {
    return [
      id,
      studentId,
      details,
      note,
      status,
      cancelReason,
      slote,
      bookedDate,
      attendance,
      type,
      paidAmount,
      paymentMethod,
      paymentDate,
      referenceId,
      createdAt,
      updatedAt,
      addedBy,
      updatedBy,
    ];
  }
}
