import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch.g.dart';

@JsonSerializable()
class Branch extends Equatable {
  final int? id;
  final String? branch;
  final String? status;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  const Branch({
    this.id,
    this.branch,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return _$BranchFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BranchToJson(this);

  Branch copyWith({
    int? id,
    String? branch,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Branch(
      id: id ?? this.id,
      branch: branch ?? this.branch,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, branch, status, createdAt, updatedAt];
}
