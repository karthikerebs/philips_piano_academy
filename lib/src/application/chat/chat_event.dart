part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetAllChatsEvent extends ChatEvent {
  const GetAllChatsEvent();

  @override
  List<Object> get props => [];
}

class SendMessageEvent extends ChatEvent {
  const SendMessageEvent({required this.msg});
  final String msg;
  @override
  List<Object> get props => [msg];
}

class DeleteMessageEvent extends ChatEvent {
  const DeleteMessageEvent({required this.msgId});
  final String msgId;
  @override
  List<Object> get props => [msgId];
}
