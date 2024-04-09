import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'common_response_model.g.dart';

@JsonSerializable()
class CommonResponseModel extends Equatable {
  final String? message;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const CommonResponseModel({this.message, this.statusCode});

  factory CommonResponseModel.fromJson(Map<String, dynamic> json) {
    return _$CommonResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CommonResponseModelToJson(this);

  CommonResponseModel copyWith({
    String? message,
    String? statusCode,
  }) {
    return CommonResponseModel(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [message, statusCode];
}
