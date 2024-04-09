import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity extends Equatable {
  final String? date;
  final String? activity;

  const Activity({this.date, this.activity});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return _$ActivityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  Activity copyWith({
    String? date,
    String? activity,
  }) {
    return Activity(
      date: date ?? this.date,
      activity: activity ?? this.activity,
    );
  }

  @override
  List<Object?> get props => [date, activity];
}
