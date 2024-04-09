import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blog.g.dart';

@JsonSerializable()
class Blog extends Equatable {
  final int? id;
  final String? title;
  final String? image;
  final String? details;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  const Blog({
    this.id,
    this.title,
    this.image,
    this.details,
    this.createdAt,
    this.updatedAt,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => _$BlogFromJson(json);

  Map<String, dynamic> toJson() => _$BlogToJson(this);

  Blog copyWith({
    int? id,
    String? title,
    String? image,
    String? details,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Blog(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      details: details ?? this.details,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      title,
      image,
      details,
      createdAt,
      updatedAt,
    ];
  }
}
