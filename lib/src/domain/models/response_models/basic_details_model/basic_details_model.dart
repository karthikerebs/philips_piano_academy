import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'basic_details_model.g.dart';

@JsonSerializable()
class BasicDetailsModel extends Equatable {
  final int? id;
  final String? name;
  final String? mobile;
  final String? email;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const BasicDetailsModel({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.statusCode,
  });

  factory BasicDetailsModel.fromJson(Map<String, dynamic> json) {
    return _$BasicDetailsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BasicDetailsModelToJson(this);

  BasicDetailsModel copyWith({
    int? id,
    String? name,
    String? mobile,
    String? email,
    String? statusCode,
  }) {
    return BasicDetailsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [id, name, mobile, email, statusCode];
}
