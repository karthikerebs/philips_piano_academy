import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'activity.dart';

part 'activity_model.g.dart';

@JsonSerializable()
class ActivityModel extends Equatable {
  final List<Activity>? activities;

  const ActivityModel({this.activities});

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return _$ActivityModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);

  ActivityModel copyWith({
    List<Activity>? activities,
  }) {
    return ActivityModel(
      activities: activities ?? this.activities,
    );
  }

  @override
  List<Object?> get props => [activities];
}
