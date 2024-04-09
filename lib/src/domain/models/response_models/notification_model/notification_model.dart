import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'notification.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel extends Equatable {
  final List<Notification>? notifications;
  final String? message;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const NotificationModel({
    this.notifications,
    this.message,
    this.statusCode,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return _$NotificationModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  NotificationModel copyWith({
    List<Notification>? notifications,
    String? message,
    String? statusCode,
  }) {
    return NotificationModel(
      notifications: notifications ?? this.notifications,
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [notifications, message, statusCode];
}
