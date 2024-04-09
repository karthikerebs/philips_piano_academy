import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'completed_class.dart';

part 'completed_class_model.g.dart';

@JsonSerializable()
class CompletedClassModel extends Equatable {
  @JsonKey(name: 'completed_classes')
  final List<CompletedClass>? completedClasses;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const CompletedClassModel({this.completedClasses, this.statusCode});

  factory CompletedClassModel.fromJson(Map<String, dynamic> json) {
    return _$CompletedClassModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CompletedClassModelToJson(this);

  CompletedClassModel copyWith({
    List<CompletedClass>? completedClasses,
    String? statusCode,
  }) {
    return CompletedClassModel(
      completedClasses: completedClasses ?? this.completedClasses,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [completedClasses, statusCode];
}
