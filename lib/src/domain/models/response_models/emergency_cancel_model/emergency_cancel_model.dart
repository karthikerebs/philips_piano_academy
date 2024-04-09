import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'emergency_cancel_model.g.dart';

@JsonSerializable()
class EmergencyCancelModel extends Equatable {
  final String? message;
  @JsonKey(name: 'emergency_cancel_prnding')
  final int? emergencyCancelPrnding;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const EmergencyCancelModel({
    this.message,
    this.emergencyCancelPrnding,
    this.statusCode,
  });

  factory EmergencyCancelModel.fromJson(Map<String, dynamic> json) {
    return _$EmergencyCancelModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EmergencyCancelModelToJson(this);

  EmergencyCancelModel copyWith({
    String? message,
    int? emergencyCancelPrnding,
    String? statusCode,
  }) {
    return EmergencyCancelModel(
      message: message ?? this.message,
      emergencyCancelPrnding:
          emergencyCancelPrnding ?? this.emergencyCancelPrnding,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props {
    return [
      message,
      emergencyCancelPrnding,
      statusCode,
    ];
  }
}
