import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'video.dart';

part 'tutorial_video_model.g.dart';

@JsonSerializable()
class TutorialVideoModel extends Equatable {
  final List<Video>? videos;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const TutorialVideoModel({this.videos, this.statusCode});

  factory TutorialVideoModel.fromJson(Map<String, dynamic> json) {
    return _$TutorialVideoModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TutorialVideoModelToJson(this);

  TutorialVideoModel copyWith({
    List<Video>? videos,
    String? statusCode,
  }) {
    return TutorialVideoModel(
      videos: videos ?? this.videos,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [videos, statusCode];
}
