import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_model.g.dart';

@JsonSerializable()
class HomeModel extends Equatable {
  final String? name;
  final String? day;
  final int? slote;

  const HomeModel({this.name, this.day, this.slote});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return _$HomeModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);

  HomeModel copyWith({
    String? name,
    String? day,
    int? slote,
  }) {
    return HomeModel(
      name: name ?? this.name,
      day: day ?? this.day,
      slote: slote ?? this.slote,
    );
  }

  @override
  List<Object?> get props => [name, day, slote];
}
