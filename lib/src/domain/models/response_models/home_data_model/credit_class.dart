import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credit_class.g.dart';

@JsonSerializable()
class CreditClass extends Equatable {
  @JsonKey(name: 'booked_date')
  final String? bookedDate;

  const CreditClass({this.bookedDate});

  factory CreditClass.fromJson(Map<String, dynamic> json) {
    return _$CreditClassFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreditClassToJson(this);

  CreditClass copyWith({
    String? bookedDate,
  }) {
    return CreditClass(
      bookedDate: bookedDate ?? this.bookedDate,
    );
  }

  @override
  List<Object?> get props => [bookedDate];
}
