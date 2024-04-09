import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pm_get_slote_model.g.dart';

@JsonSerializable()
class PmGetSloteModel extends Equatable {
  final String? day;

  const PmGetSloteModel({this.day});

  factory PmGetSloteModel.fromJson(Map<String, dynamic> json) {
    return _$PmGetSloteModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PmGetSloteModelToJson(this);

  PmGetSloteModel copyWith({
    String? day,
  }) {
    return PmGetSloteModel(
      day: day ?? this.day,
    );
  }

  @override
  List<Object?> get props => [day];
}
