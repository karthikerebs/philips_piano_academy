import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

@JsonSerializable()
class Video extends Equatable {
  final int? id;
  final String? title;
  final String? link;
  final dynamic details;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  const Video({
    this.id,
    this.title,
    this.link,
    this.details,
    this.createdAt,
    this.updatedAt,
  });

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);

  Video copyWith({
    int? id,
    String? title,
    String? link,
    dynamic details,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Video(
      id: id ?? this.id,
      title: title ?? this.title,
      link: link ?? this.link,
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
      link,
      details,
      createdAt,
      updatedAt,
    ];
  }
}
