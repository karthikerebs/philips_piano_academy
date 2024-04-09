import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/domain/chat/i_chat_repository.dart';
import 'package:music_app/src/domain/core/failures/api_auth_failure.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/models/response_models/chat_model/chat.dart';

part 'chat_event.dart';
part 'chat_state.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this._iChatRepository) : super(const ChatState()) {
    on<GetAllChatsEvent>(_getAllChats);
    on<SendMessageEvent>(_sendMessage);
    on<DeleteMessageEvent>(_deleteMessage);
  }
  FutureOr<void> _getAllChats(
      GetAllChatsEvent event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(status: StatusLoading()));
      final res = await _iChatRepository.getAllChats();
      if (res.statusCode == '01') {
        emit(state.copyWith(status: StatusSuccess(), chatList: res.chats));
      } else {
        emit(state.copyWith(status: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(status: StatusAuthFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(status: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _sendMessage(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(sendStatus: StatusLoading()));
      final res = await _iChatRepository.sendMessage(msg: event.msg);
      if (res.statusCode == '01') {
        emit(state.copyWith(sendStatus: StatusSuccess()));
      } else {
        emit(state.copyWith(
            sendStatus: StatusFailure(res.message ?? "Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(sendStatus: StatusAuthFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(sendStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _deleteMessage(
      DeleteMessageEvent event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(deleteStatus: StatusLoading()));
      final res = await _iChatRepository.deleteMessage(msgId: event.msgId);
      if (res.statusCode == '01') {
        state.chatList
            .removeWhere((element) => element.id.toString() == event.msgId);
        emit(state.copyWith(deleteStatus: StatusSuccess()));
      } else {
        emit(state.copyWith(
            deleteStatus: StatusFailure(res.message ?? "Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(deleteStatus: StatusAuthFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(deleteStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  final IChatRepossitory _iChatRepository;
}
