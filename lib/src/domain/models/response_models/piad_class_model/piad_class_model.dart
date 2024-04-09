import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'paid_class.dart';

part 'piad_class_model.g.dart';

@JsonSerializable()
class PiadClassModel extends Equatable {
  @JsonKey(name: 'paid_classes')
  final List<PaidClass>? paidClasses;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const PiadClassModel({this.paidClasses, this.statusCode});

  factory PiadClassModel.fromJson(Map<String, dynamic> json) {
    return _$PiadClassModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PiadClassModelToJson(this);

  PiadClassModel copyWith({
    List<PaidClass>? paidClasses,
    String? statusCode,
  }) {
    return PiadClassModel(
      paidClasses: paidClasses ?? this.paidClasses,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [paidClasses, statusCode];
}
