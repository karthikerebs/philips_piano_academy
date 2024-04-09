import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_payment_status_model.g.dart';

@JsonSerializable()
class GetPaymentStatusModel extends Equatable {
  @JsonKey(name: 'onlinepay_status')
  final String? onlinepayStatus;

  const GetPaymentStatusModel({this.onlinepayStatus});

  factory GetPaymentStatusModel.fromJson(Map<String, dynamic> json) {
    return _$GetPaymentStatusModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetPaymentStatusModelToJson(this);

  GetPaymentStatusModel copyWith({
    String? onlinepayStatus,
  }) {
    return GetPaymentStatusModel(
      onlinepayStatus: onlinepayStatus ?? this.onlinepayStatus,
    );
  }

  @override
  List<Object?> get props => [onlinepayStatus];
}
