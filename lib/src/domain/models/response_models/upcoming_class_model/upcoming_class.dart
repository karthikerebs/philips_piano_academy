import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'date.dart';

part 'upcoming_class.g.dart';

@JsonSerializable()
class UpcomingClass extends Equatable {
  final String? month;
  final List<Date>? dates;

  const UpcomingClass({this.month, this.dates});

  factory UpcomingClass.fromJson(Map<String, dynamic> json) {
    return _$UpcomingClassFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpcomingClassToJson(this);

  UpcomingClass copyWith({
    String? month,
    List<Date>? dates,
  }) {
    return UpcomingClass(
      month: month ?? this.month,
      dates: dates ?? this.dates,
    );
  }

  @override
  List<Object?> get props => [month, dates];
}
