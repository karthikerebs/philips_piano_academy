import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'date.g.dart';

@JsonSerializable()
class Date extends Equatable {
  final String? date;
  final String? slote;
  final String? status;
  @JsonKey(name: 'cancel_status')
  final bool? cancelStatus;
  @JsonKey(name: 'emergency_cancel')
  final bool? emergencyCancel;

  const Date({
    this.date,
    this.slote,
    this.status,
    this.cancelStatus,
    this.emergencyCancel,
  });

  factory Date.fromJson(Map<String, dynamic> json) => _$DateFromJson(json);

  Map<String, dynamic> toJson() => _$DateToJson(this);

  Date copyWith({
    String? date,
    String? slote,
    String? status,
    bool? cancelStatus,
    bool? emergencyCancel,
  }) {
    return Date(
      date: date ?? this.date,
      slote: slote ?? this.slote,
      status: status ?? this.status,
      cancelStatus: cancelStatus ?? this.cancelStatus,
      emergencyCancel: emergencyCancel ?? this.emergencyCancel,
    );
  }

  @override
  List<Object?> get props {
    return [
      date,
      slote,
      status,
      cancelStatus,
      emergencyCancel,
    ];
  }
}
