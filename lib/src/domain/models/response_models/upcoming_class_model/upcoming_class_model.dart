import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'upcoming_class.dart';

part 'upcoming_class_model.g.dart';

@JsonSerializable()
class UpcomingClassModel extends Equatable {
  @JsonKey(name: 'upcoming_classes')
  final List<UpcomingClass>? upcomingClasses;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const UpcomingClassModel({this.upcomingClasses, this.statusCode});

  factory UpcomingClassModel.fromJson(Map<String, dynamic> json) {
    return _$UpcomingClassModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpcomingClassModelToJson(this);

  UpcomingClassModel copyWith({
    List<UpcomingClass>? upcomingClasses,
    String? statusCode,
  }) {
    return UpcomingClassModel(
      upcomingClasses: upcomingClasses ?? this.upcomingClasses,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [upcomingClasses, statusCode];
}
