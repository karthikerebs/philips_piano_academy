import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'installment.dart';

part 'installment_model.g.dart';

@JsonSerializable()
class InstallmentModel extends Equatable {
  final List<Installment>? installments;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const InstallmentModel({this.installments, this.statusCode});

  factory InstallmentModel.fromJson(Map<String, dynamic> json) {
    return _$InstallmentModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InstallmentModelToJson(this);

  InstallmentModel copyWith({
    List<Installment>? installments,
    String? statusCode,
  }) {
    return InstallmentModel(
      installments: installments ?? this.installments,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [installments, statusCode];
}
