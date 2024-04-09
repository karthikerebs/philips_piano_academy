import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_paid_class.g.dart';

@JsonSerializable()
class CheckPaidClass extends Equatable {
  final String? message;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const CheckPaidClass({this.message, this.statusCode});

  factory CheckPaidClass.fromJson(Map<String, dynamic> json) {
    return _$CheckPaidClassFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CheckPaidClassToJson(this);

  CheckPaidClass copyWith({
    String? message,
    String? statusCode,
  }) {
    return CheckPaidClass(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [message, statusCode];
}
