import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'dates_and_available_slote.dart';

part 'upcoming_slotes_model.g.dart';

@JsonSerializable()
class UpcomingSlotesModel extends Equatable {
  @JsonKey(name: 'dates_and_available_slotes')
  final List<DatesAndAvailableSlote>? datesAndAvailableSlotes;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const UpcomingSlotesModel({
    this.datesAndAvailableSlotes,
    this.statusCode,
  });

  factory UpcomingSlotesModel.fromJson(Map<String, dynamic> json) {
    return _$UpcomingSlotesModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpcomingSlotesModelToJson(this);

  UpcomingSlotesModel copyWith({
    List<DatesAndAvailableSlote>? datesAndAvailableSlotes,
    String? statusCode,
  }) {
    return UpcomingSlotesModel(
      datesAndAvailableSlotes:
          datesAndAvailableSlotes ?? this.datesAndAvailableSlotes,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [datesAndAvailableSlotes, statusCode];
}
