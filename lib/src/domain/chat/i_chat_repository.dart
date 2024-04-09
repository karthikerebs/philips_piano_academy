import 'package:music_app/src/domain/models/response_models/chat_model/chat_model.dart';
import 'package:music_app/src/domain/models/response_models/common_response_model/common_response_model.dart';

abstract class IChatRepossitory {
  Future<ChatModel> getAllChats();
  Future<CommonResponseModel> sendMessage({required String msg});
  Future<CommonResponseModel> deleteMessage({required String msgId});
}
