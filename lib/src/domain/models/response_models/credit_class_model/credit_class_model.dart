import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'credit_class.dart';

part 'credit_class_model.g.dart';

@JsonSerializable()
class CreditClassModel extends Equatable {
  @JsonKey(name: 'credit_classes')
  final List<CreditClass>? creditClasses;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const CreditClassModel({this.creditClasses, this.statusCode});

  factory CreditClassModel.fromJson(Map<String, dynamic> json) {
    return _$CreditClassModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreditClassModelToJson(this);

  CreditClassModel copyWith({
    List<CreditClass>? creditClasses,
    String? statusCode,
  }) {
    return CreditClassModel(
      creditClasses: creditClasses ?? this.creditClasses,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [creditClasses, statusCode];
}
