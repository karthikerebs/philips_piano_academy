import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cancelled_class.g.dart';

@JsonSerializable()
class CancelledClass extends Equatable {
  final int? id;
  @JsonKey(name: 'class_date')
  final String? classDate;
  @JsonKey(name: 'student_id')
  final int? studentId;
  final int? slote;
  final String? reason;
  final String? status;
  @JsonKey(name: 'rebooked_status')
  final String? rebookedStatus;
  @JsonKey(name: 'rebooked_by')
  final dynamic rebookedBy;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  const CancelledClass({
    this.id,
    this.classDate,
    this.studentId,
    this.slote,
    this.reason,
    this.status,
    this.rebookedStatus,
    this.rebookedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory CancelledClass.fromJson(Map<String, dynamic> json) {
    return _$CancelledClassFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CancelledClassToJson(this);

  CancelledClass copyWith({
    int? id,
    String? classDate,
    int? studentId,
    int? slote,
    String? reason,
    String? status,
    String? rebookedStatus,
    dynamic rebookedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CancelledClass(
      id: id ?? this.id,
      classDate: classDate ?? this.classDate,
      studentId: studentId ?? this.studentId,
      slote: slote ?? this.slote,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      rebookedStatus: rebookedStatus ?? this.rebookedStatus,
      rebookedBy: rebookedBy ?? this.rebookedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      classDate,
      studentId,
      slote,
      reason,
      status,
      rebookedStatus,
      rebookedBy,
      createdAt,
      updatedAt,
    ];
  }
}
