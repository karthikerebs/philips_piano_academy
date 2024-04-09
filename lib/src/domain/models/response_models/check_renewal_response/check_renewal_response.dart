import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_renewal_response.g.dart';

@JsonSerializable()
class CheckRenewalResponse extends Equatable {
  final String? message;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const CheckRenewalResponse({this.message, this.statusCode});

  factory CheckRenewalResponse.fromJson(Map<String, dynamic> json) {
    return _$CheckRenewalResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CheckRenewalResponseToJson(this);

  CheckRenewalResponse copyWith({
    String? message,
    String? statusCode,
  }) {
    return CheckRenewalResponse(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [message, statusCode];
}
