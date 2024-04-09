import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

@JsonSerializable()
class RegisterModel extends Equatable {
  final String? message;
  final String? token;
  final String? name;
  @JsonKey(name: 'class_mode')
  final String? classMode;
  final int? slote;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const RegisterModel({
    this.message,
    this.token,
    this.name,
    this.classMode,
    this.slote,
    this.statusCode,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return _$RegisterModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);

  RegisterModel copyWith({
    String? message,
    String? token,
    String? name,
    String? classMode,
    int? slote,
    String? statusCode,
  }) {
    return RegisterModel(
      message: message ?? this.message,
      token: token ?? this.token,
      name: name ?? this.name,
      classMode: classMode ?? this.classMode,
      slote: slote ?? this.slote,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props {
    return [
      message,
      token,
      name,
      classMode,
      slote,
      statusCode,
    ];
  }
}
