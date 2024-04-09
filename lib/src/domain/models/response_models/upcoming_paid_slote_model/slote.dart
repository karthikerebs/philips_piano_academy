import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'slote.g.dart';

@JsonSerializable()
class Slote extends Equatable {
  final int? id;
  @JsonKey(name: 'class_mode')
  final String? classMode;
  final int? branch;
  final String? day;
  final String? slote;
  @JsonKey(name: 'slote_limit')
  final int? sloteLimit;
  final String? status;
  final String? availability;

  const Slote({
    this.id,
    this.classMode,
    this.branch,
    this.day,
    this.slote,
    this.sloteLimit,
    this.status,
    this.availability,
  });

  factory Slote.fromJson(Map<String, dynamic> json) => _$SloteFromJson(json);

  Map<String, dynamic> toJson() => _$SloteToJson(this);

  Slote copyWith({
    int? id,
    String? classMode,
    int? branch,
    String? day,
    String? slote,
    int? sloteLimit,
    String? status,
    String? availability,
  }) {
    return Slote(
      id: id ?? this.id,
      classMode: classMode ?? this.classMode,
      branch: branch ?? this.branch,
      day: day ?? this.day,
      slote: slote ?? this.slote,
      sloteLimit: sloteLimit ?? this.sloteLimit,
      status: status ?? this.status,
      availability: availability ?? this.availability,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      classMode,
      branch,
      day,
      slote,
      sloteLimit,
      status,
      availability,
    ];
  }
}
