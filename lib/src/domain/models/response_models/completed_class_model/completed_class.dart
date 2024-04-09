import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'completed_class.g.dart';

@JsonSerializable()
class CompletedClass extends Equatable {
  final int? id;
  @JsonKey(name: 'at_date')
  final String? atDate;
  @JsonKey(name: 'student_id')
  final int? studentId;
  final int? slote;
  final dynamic note;
  final String? status;
  @JsonKey(name: 'added_by')
  final String? addedBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'extra_status')
  final bool? extraStatus;

  const CompletedClass(
      {this.id,
      this.atDate,
      this.studentId,
      this.slote,
      this.note,
      this.status,
      this.addedBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.extraStatus});

  factory CompletedClass.fromJson(Map<String, dynamic> json) {
    return _$CompletedClassFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CompletedClassToJson(this);

  CompletedClass copyWith(
      {int? id,
      String? atDate,
      int? studentId,
      int? slote,
      dynamic note,
      String? status,
      String? addedBy,
      String? updatedBy,
      DateTime? createdAt,
      DateTime? updatedAt,
      bool? extraStatus}) {
    return CompletedClass(
        id: id ?? this.id,
        atDate: atDate ?? this.atDate,
        studentId: studentId ?? this.studentId,
        slote: slote ?? this.slote,
        note: note ?? this.note,
        status: status ?? this.status,
        addedBy: addedBy ?? this.addedBy,
        updatedBy: updatedBy ?? this.updatedBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        extraStatus: extraStatus ?? this.extraStatus);
  }

  @override
  List<Object?> get props {
    return [
      id,
      atDate,
      studentId,
      slote,
      note,
      status,
      addedBy,
      updatedBy,
      createdAt,
      updatedAt,
      extraStatus
    ];
  }
}
