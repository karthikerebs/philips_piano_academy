import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'slote.dart';

part 'slot_model.g.dart';

@JsonSerializable()
class SlotModel extends Equatable {
  final List<Slote>? slotes;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const SlotModel({this.slotes, this.statusCode});

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return _$SlotModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SlotModelToJson(this);

  SlotModel copyWith({
    List<Slote>? slotes,
    String? statusCode,
  }) {
    return SlotModel(
      slotes: slotes ?? this.slotes,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [slotes, statusCode];
}
