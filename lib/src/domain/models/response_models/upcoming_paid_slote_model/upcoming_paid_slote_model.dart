import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'dates_and_available_slote.dart';

part 'upcoming_paid_slote_model.g.dart';

@JsonSerializable()
class UpcomingPaidSloteModel extends Equatable {
  final String? fee;
  @JsonKey(name: 'dates_and_available_slotes')
  final List<DatesAndAvailableSlote>? datesAndAvailableSlotes;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const UpcomingPaidSloteModel({
    this.fee,
    this.datesAndAvailableSlotes,
    this.statusCode,
  });

  factory UpcomingPaidSloteModel.fromJson(Map<String, dynamic> json) {
    return _$UpcomingPaidSloteModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpcomingPaidSloteModelToJson(this);

  UpcomingPaidSloteModel copyWith({
    String? fee,
    List<DatesAndAvailableSlote>? datesAndAvailableSlotes,
    String? statusCode,
  }) {
    return UpcomingPaidSloteModel(
      fee: fee ?? this.fee,
      datesAndAvailableSlotes:
          datesAndAvailableSlotes ?? this.datesAndAvailableSlotes,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [fee, datesAndAvailableSlotes, statusCode];
}
