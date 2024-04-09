part of 'chat_bloc.dart';

class ChatState extends Equatable {
  const ChatState(
      {this.status = const StatusInitial(),
      this.deleteStatus = const StatusInitial(),
      this.sendStatus = const StatusInitial(),
      this.chatList = const <Chat>[]});
  final Status status;
  final List<Chat> chatList;
  final Status sendStatus;
  final Status deleteStatus;
  @override
  List<Object> get props => [status, chatList, sendStatus, deleteStatus];
  ChatState copyWith(
      {Status? status,
      List<Chat>? chatList,
      Status? sendStatus,
      Status? deleteStatus}) {
    return ChatState(
        chatList: chatList ?? this.chatList,
        deleteStatus: deleteStatus ?? this.deleteStatus,
        sendStatus: sendStatus ?? this.sendStatus,
        status: status ?? this.status);
  }
}
