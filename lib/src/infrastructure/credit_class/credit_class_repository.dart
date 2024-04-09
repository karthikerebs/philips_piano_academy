import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:music_app/src/domain/core/app_url/app_urls.dart';
import 'package:music_app/src/domain/core/failures/api_auth_failure.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/core/internet_service/i_base_client.dart';
import 'package:music_app/src/domain/credit_class/i_credit_class_repository.dart';
import 'package:music_app/src/domain/models/response_models/common_response_model/common_response_model.dart';
import 'package:music_app/src/domain/models/response_models/credit_class_model/credit_class_model.dart';
import 'package:music_app/src/domain/models/response_models/emergency_cancel_model/emergency_cancel_model.dart';
import 'package:music_app/src/domain/models/response_models/slot_model/slot_model.dart';
import 'package:music_app/src/domain/models/response_models/upcoming_slotes_model/upcoming_slotes_model.dart';

@LazySingleton(as: ICreditClassRepository)
class CreditClassRepository extends ICreditClassRepository {
  final IBaseClient client;

  CreditClassRepository(this.client);

  @override
  Future<CreditClassModel> getCreditClass() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.getCreditClassUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      return CreditClassModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<SlotModel> getCreditClassSlotes({required String date}) async {
    try {
      final response = await client.postWithProfile(
          url: AppUrls.getCreditClassSloteUrl, body: {"class_date": date});
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      return SlotModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<CommonResponseModel> bookCreditClass(
      {required String date,
      required String classId,
      required String slotId}) async {
    try {
      final response = await client.postWithProfile(
          url: AppUrls.bookCreditClassUrl,
          body: {"class_date": date, "slote_id": slotId, "class_id": classId});
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      return CommonResponseModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<CommonResponseModel> cancelCreditClass(
      {required String classId, required String reason}) async {
    try {
      final response = await client.postWithProfile(
          url: AppUrls.cancelCreditClassUrl,
          body: {"class_id": classId, "reason": reason});
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      return CommonResponseModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<EmergencyCancelModel> emergencyCancelClass(
      {required String classId, required String reason}) async {
    try {
      final response = await client.postWithProfile(
          url: AppUrls.emergencyCancelCreditUrl,
          body: {"reason": reason, "class_id": classId});
      final decode = jsonDecode(response.body) as Map<String, dynamic>;

      return EmergencyCancelModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<UpcomingSlotesModel> getUpcomingSlotes() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.upcomingSlotesUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      return UpcomingSlotesModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }
}
