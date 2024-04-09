import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'cancelled_class.dart';

part 'cancelled_class_model.g.dart';

@JsonSerializable()
class CancelledClassModel extends Equatable {
  @JsonKey(name: 'cancelled_classes')
  final List<CancelledClass>? cancelledClasses;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const CancelledClassModel({this.cancelledClasses, this.statusCode});

  factory CancelledClassModel.fromJson(Map<String, dynamic> json) {
    return _$CancelledClassModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CancelledClassModelToJson(this);

  CancelledClassModel copyWith({
    List<CancelledClass>? cancelledClasses,
    String? statusCode,
  }) {
    return CancelledClassModel(
      cancelledClasses: cancelledClasses ?? this.cancelledClasses,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [cancelledClasses, statusCode];
}
