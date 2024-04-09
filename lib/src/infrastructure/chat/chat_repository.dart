import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:music_app/src/domain/chat/i_chat_repository.dart';
import 'package:music_app/src/domain/core/app_url/app_urls.dart';
import 'package:music_app/src/domain/core/failures/api_auth_failure.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/core/internet_service/i_base_client.dart';
import 'package:music_app/src/domain/models/response_models/chat_model/chat_model.dart';
import 'package:music_app/src/domain/models/response_models/common_response_model/common_response_model.dart';

@LazySingleton(as: IChatRepossitory)
class ChatRepository extends IChatRepossitory {
  final IBaseClient client;

  ChatRepository(this.client);
  @override
  Future<CommonResponseModel> deleteMessage({required String msgId}) async {
    try {
      final response = await client.postWithProfile(
          url: AppUrls.deleteMessageUrl, body: {"msg_id": msgId});
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      return CommonResponseModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<ChatModel> getAllChats() async {
    try {
      final response = await client.getWithProfile(url: AppUrls.getAllChatUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      return ChatModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<CommonResponseModel> sendMessage({required String msg}) async {
    try {
      final response = await client
          .postWithProfile(url: AppUrls.sendMessageUrl, body: {"msg": msg});
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      return CommonResponseModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }
}
