import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'slote.dart';

part 'dates_and_available_slote.g.dart';

@JsonSerializable()
class DatesAndAvailableSlote extends Equatable {
  final String? date;
  final List<Slote>? slotes;

  const DatesAndAvailableSlote({this.date, this.slotes});

  factory DatesAndAvailableSlote.fromJson(Map<String, dynamic> json) {
    return _$DatesAndAvailableSloteFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DatesAndAvailableSloteToJson(this);

  DatesAndAvailableSlote copyWith({
    String? date,
    List<Slote>? slotes,
  }) {
    return DatesAndAvailableSlote(
      date: date ?? this.date,
      slotes: slotes ?? this.slotes,
    );
  }

  @override
  List<Object?> get props => [date, slotes];
}
