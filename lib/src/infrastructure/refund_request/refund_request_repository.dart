import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:music_app/src/domain/core/app_url/app_urls.dart';
import 'package:music_app/src/domain/core/failures/api_auth_failure.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/core/internet_service/i_base_client.dart';
import 'package:music_app/src/domain/models/response_models/common_response_model/common_response_model.dart';
import 'package:music_app/src/domain/models/response_models/refund_request_model/refund_request_model.dart';
import 'package:music_app/src/domain/refund_request/i_refund_repository.dart';

@LazySingleton(as: IRefundRequestRepository)
class RefundRequestRepository extends IRefundRequestRepository {
  final IBaseClient client;

  RefundRequestRepository(this.client);

  @override
  Future<RefundRequestModel> getRefundRequests() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.getRefundRequestUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;

      return RefundRequestModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<CommonResponseModel> sendRefundRequests(
      {required String date, required String reason}) async {
    try {
      final response = await client.postWithProfile(
          url: AppUrls.sendRefundRequestUrl,
          body: {"leaving_date": date, "reason": reason});
      final decode = jsonDecode(response.body) as Map<String, dynamic>;

      return CommonResponseModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }
}
