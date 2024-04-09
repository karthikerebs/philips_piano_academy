import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification extends Equatable {
  final int? id;
  final String? title;
  @JsonKey(name: 'noti_type')
  final String? notiType;
  final String? msg;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  const Notification({
    this.id,
    this.title,
    this.notiType,
    this.msg,
    this.createdAt,
    this.updatedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return _$NotificationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  Notification copyWith({
    int? id,
    String? title,
    String? notiType,
    String? msg,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Notification(
      id: id ?? this.id,
      title: title ?? this.title,
      notiType: notiType ?? this.notiType,
      msg: msg ?? this.msg,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      title,
      notiType,
      msg,
      createdAt,
      updatedAt,
    ];
  }
}
