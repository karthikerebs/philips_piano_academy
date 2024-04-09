// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutorial_video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorialVideoModel _$TutorialVideoModelFromJson(Map<String, dynamic> json) =>
    TutorialVideoModel(
      videos: (json['videos'] as List<dynamic>?)
          ?.map((e) => Video.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$TutorialVideoModelToJson(TutorialVideoModel instance) =>
    <String, dynamic>{
      'videos': instance.videos,
      'status_code': instance.statusCode,
    };
