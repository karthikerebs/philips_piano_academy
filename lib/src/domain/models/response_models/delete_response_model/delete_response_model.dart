import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_response_model.g.dart';

@JsonSerializable()
class DeleteResponseModel extends Equatable {
  final String? message;

  const DeleteResponseModel({this.message});

  factory DeleteResponseModel.fromJson(Map<String, dynamic> json) {
    return _$DeleteResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DeleteResponseModelToJson(this);

  DeleteResponseModel copyWith({
    String? message,
  }) {
    return DeleteResponseModel(
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [message];
}
