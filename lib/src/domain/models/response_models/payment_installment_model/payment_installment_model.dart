import 'package:json_annotation/json_annotation.dart';

import 'installment.dart';

part 'payment_installment_model.g.dart';

@JsonSerializable()
class PaymentInstallmentModel {
  List<PaymentInstallment>? installments;
  @JsonKey(name: 'status_code')
  String? statusCode;

  PaymentInstallmentModel({this.installments, this.statusCode});

  factory PaymentInstallmentModel.fromJson(Map<String, dynamic> json) {
    return _$PaymentInstallmentModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaymentInstallmentModelToJson(this);

  PaymentInstallmentModel copyWith({
    List<PaymentInstallment>? installments,
    String? statusCode,
  }) {
    return PaymentInstallmentModel(
      installments: installments ?? this.installments,
      statusCode: statusCode ?? this.statusCode,
    );
  }
}
