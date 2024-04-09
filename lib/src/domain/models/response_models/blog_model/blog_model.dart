import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'blog.dart';

part 'blog_model.g.dart';

@JsonSerializable()
class BlogModel extends Equatable {
  final List<Blog>? blogs;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const BlogModel({this.blogs, this.statusCode});

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return _$BlogModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BlogModelToJson(this);

  BlogModel copyWith({
    List<Blog>? blogs,
    String? statusCode,
  }) {
    return BlogModel(
      blogs: blogs ?? this.blogs,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [blogs, statusCode];
}
