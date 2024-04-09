import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:music_app/src/domain/core/app_url/app_urls.dart';
import 'package:music_app/src/domain/core/failures/api_auth_failure.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/core/internet_service/i_base_client.dart';
import 'package:music_app/src/domain/models/pm_models/pm_send_renew_request_model/pm_send_renew_request_model.dart';
import 'package:music_app/src/domain/models/response_models/check_renewal_response/check_renewal_response.dart';
import 'package:music_app/src/domain/models/response_models/common_response_model/common_response_model.dart';
import 'package:music_app/src/domain/models/response_models/get_renewal_fees_model/get_renewal_fees_model.dart';
import 'package:music_app/src/domain/models/response_models/plans_model/plans_model.dart';
import 'package:music_app/src/domain/models/response_models/renewal_fee_details/renewal_fee_details.dart';
import 'package:music_app/src/domain/renewal/i_renewal_repository.dart';

@LazySingleton(as: IRenewalRepository)
class RenewalRequestRepository extends IRenewalRepository {
  final IBaseClient client;

  RenewalRequestRepository(this.client);

  @override
  Future<RenewalFeeDetails> getRenewalFeeDetails(
      {required String months}) async {
    try {
      final response = await client.postWithProfile(
          url: AppUrls.renewalFeeDetailsUrl, body: {"months": months});
      final decode = jsonDecode(response.body) as Map<String, dynamic>;

      return RenewalFeeDetails.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<PlansModel> getPlans() async {
    try {
      final response = await client.getWithProfile(url: AppUrls.getPlansUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;

      return PlansModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<CommonResponseModel> sendRenewalRequest(
      {required PmSendRenewRequestModel params}) async {
    try {
      final response = await client.postWithProfile(
          url: AppUrls.renewalRequestUrl, body: params.toJson());
      final decode = jsonDecode(response.body) as Map<String, dynamic>;

      return CommonResponseModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<GetRenewalFeesModel> getRenewalFees() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.getRenewalFeesUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      if (decode['status_code'] == "01") {
        return GetRenewalFeesModel.fromJson(decode);
      } else {
        throw ApiFailure(message: decode['message']);
      }
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<CheckRenewalResponse> checkRenewal() async {
    try {
      final response = await client.getWithProfile(url: AppUrls.checkRenwalUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      if (decode['status_code'] == "01") {
        return CheckRenewalResponse.fromJson(decode);
      } else {
        throw ApiFailure(message: decode['message']);
      }
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }
}
