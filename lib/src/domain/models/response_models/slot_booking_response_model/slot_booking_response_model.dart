import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'slot_booking_response_model.g.dart';

@JsonSerializable()
class SlotBookingResponseModel extends Equatable {
  final String? message;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const SlotBookingResponseModel({this.message, this.statusCode});

  factory SlotBookingResponseModel.fromJson(Map<String, dynamic> json) {
    return _$SlotBookingResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SlotBookingResponseModelToJson(this);

  SlotBookingResponseModel copyWith({
    String? message,
    String? statusCode,
  }) {
    return SlotBookingResponseModel(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [message, statusCode];
}
