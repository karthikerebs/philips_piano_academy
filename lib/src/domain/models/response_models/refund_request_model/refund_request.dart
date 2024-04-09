import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refund_request.g.dart';

@JsonSerializable()
class RefundRequest extends Equatable {
  final int? id;
  @JsonKey(name: 'student_id')
  final int? studentId;
  final String? status;
  @JsonKey(name: 'rejection_reason')
  final dynamic rejectionReason;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  const RefundRequest({
    this.id,
    this.studentId,
    this.status,
    this.rejectionReason,
    this.createdAt,
    this.updatedAt,
  });

  factory RefundRequest.fromJson(Map<String, dynamic> json) {
    return _$RefundRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RefundRequestToJson(this);

  RefundRequest copyWith({
    int? id,
    int? studentId,
    String? status,
    dynamic rejectionReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RefundRequest(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      status: status ?? this.status,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      studentId,
      status,
      rejectionReason,
      createdAt,
      updatedAt,
    ];
  }
}
