import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'chat.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel extends Equatable {
  final List<Chat>? chats;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const ChatModel({this.chats, this.statusCode});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return _$ChatModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  ChatModel copyWith({
    List<Chat>? chats,
    String? statusCode,
  }) {
    return ChatModel(
      chats: chats ?? this.chats,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [chats, statusCode];
}
