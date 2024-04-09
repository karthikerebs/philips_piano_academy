import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'branch.dart';

part 'branch_model.g.dart';

@JsonSerializable()
class BranchModel extends Equatable {
  final List<Branch>? branches;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const BranchModel({this.branches, this.statusCode});

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return _$BranchModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BranchModelToJson(this);

  BranchModel copyWith({
    List<Branch>? branches,
    String? statusCode,
  }) {
    return BranchModel(
      branches: branches ?? this.branches,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [branches, statusCode];
}
