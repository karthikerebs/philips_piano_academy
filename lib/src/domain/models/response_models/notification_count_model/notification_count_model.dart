import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_count_model.g.dart';

@JsonSerializable()
class NotificationCountModel extends Equatable {
  @JsonKey(name: 'new_notifications')
  final int? newNotifications;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const NotificationCountModel({this.newNotifications, this.statusCode});

  factory NotificationCountModel.fromJson(Map<String, dynamic> json) {
    return _$NotificationCountModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NotificationCountModelToJson(this);

  NotificationCountModel copyWith({
    int? newNotifications,
    String? statusCode,
  }) {
    return NotificationCountModel(
      newNotifications: newNotifications ?? this.newNotifications,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [newNotifications, statusCode];
}
