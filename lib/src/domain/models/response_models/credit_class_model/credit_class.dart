import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credit_class.g.dart';

@JsonSerializable()
class CreditClass extends Equatable {
  final int? id;
  final String? status;
  @JsonKey(name: 'booked_date')
  final dynamic bookedDate;
  @JsonKey(name: 'due_date')
  final String? dueDate;
  final String? attendance;
  @JsonKey(name: 'slote_time')
  final dynamic sloteTime;
  @JsonKey(name: 'book_status')
  final bool? bookStatus;
  @JsonKey(name: 'cancel_status')
  final bool? cancelStatus;
  @JsonKey(name: 'emergency_cancel')
  final bool? emergencyCancel;
  final String? details;
  @JsonKey(name: 'added_by')
  final String? addedBy;

  const CreditClass(
      {this.id,
      this.status,
      this.bookedDate,
      this.dueDate,
      this.attendance,
      this.sloteTime,
      this.bookStatus,
      this.cancelStatus,
      this.emergencyCancel,
      this.details,
      this.addedBy});

  factory CreditClass.fromJson(Map<String, dynamic> json) {
    return _$CreditClassFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreditClassToJson(this);

  CreditClass copyWith(
      {int? id,
      String? status,
      dynamic bookedDate,
      String? dueDate,
      String? attendance,
      dynamic sloteTime,
      bool? bookStatus,
      bool? cancelStatus,
      bool? emergencyCancel,
      String? details,
      String? addedBy}) {
    return CreditClass(
        id: id ?? this.id,
        status: status ?? this.status,
        bookedDate: bookedDate ?? this.bookedDate,
        dueDate: dueDate ?? this.dueDate,
        attendance: attendance ?? this.attendance,
        sloteTime: sloteTime ?? this.sloteTime,
        bookStatus: bookStatus ?? this.bookStatus,
        cancelStatus: cancelStatus ?? this.cancelStatus,
        emergencyCancel: emergencyCancel ?? this.emergencyCancel,
        details: details ?? this.details,
        addedBy: addedBy ?? this.addedBy);
  }

  @override
  List<Object?> get props {
    return [
      id,
      status,
      bookedDate,
      dueDate,
      attendance,
      sloteTime,
      bookStatus,
      cancelStatus,
      emergencyCancel,
      details,
      addedBy
    ];
  }
}
