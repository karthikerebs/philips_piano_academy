import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'logout_model.g.dart';

@JsonSerializable()
class LogoutModel extends Equatable {
  final String? message;

  const LogoutModel({this.message});

  factory LogoutModel.fromJson(Map<String, dynamic> json) {
    return _$LogoutModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LogoutModelToJson(this);

  LogoutModel copyWith({
    String? message,
  }) {
    return LogoutModel(
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [message];
}
