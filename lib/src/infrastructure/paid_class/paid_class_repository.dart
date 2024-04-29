import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:music_app/src/domain/core/app_url/app_urls.dart';
import 'package:music_app/src/domain/core/failures/api_auth_failure.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/core/internet_service/i_base_client.dart';
import 'package:music_app/src/domain/models/pm_models/pm_paid_webhook/pm_paid_webhook.dart';
import 'package:music_app/src/domain/models/response_models/check_paid_class/check_paid_class.dart';
import 'package:music_app/src/domain/models/response_models/common_response_model/common_response_model.dart';
import 'package:music_app/src/domain/models/response_models/completed_note_model/completed_note_model.dart';
import 'package:music_app/src/domain/models/response_models/paid_class_slot_model/paid_class_slot_model.dart';
import 'package:music_app/src/domain/models/response_models/piad_class_model/piad_class_model.dart';
import 'package:music_app/src/domain/models/response_models/upcoming_paid_slote_model/upcoming_paid_slote_model.dart';
import 'package:music_app/src/domain/paid_class/i_paid_class_repository.dart';

@LazySingleton(as: IPaidClassRepository)
class PaidClassRepository extends IPaidClassRepository {
  final IBaseClient client;

  PaidClassRepository(this.client);

  @override
  Future<PaidClassSlotModel> getPaidClassSlotes({required String date}) async {
    try {
      final response = await client.postWithProfile(
          url: AppUrls.getPaidClassSloteUrl, body: {"class_date": date});
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      if (decode['status_code'] == "01") {
        return PaidClassSlotModel.fromJson(decode);
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
  Future<CommonResponseModel> bookPaidClass(
      {required String sloteId,
      required String classDate,
      required String paidAmount,
      required String referenceId}) async {
    try {
      final response = await client
          .postWithProfile(url: AppUrls.bookPaidClassSloteUrl, body: {
        "class_date": classDate,
        "slote_id": sloteId,
        "paid_amount": paidAmount,
        "reference_id": referenceId
      });
      final decode = jsonDecode(response.body) as Map<String, dynamic>;

      return CommonResponseModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<PiadClassModel> getAllPaidClass() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.getAllPaidClassesUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;

      return PiadClassModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<CommonResponseModel> cancelPaidClass(
      {required String reason, required String id}) async {
    try {
      final response = await client.postWithProfile(
          url: AppUrls.cancelPaidClassUrl,
          body: {"reason": reason, "class_id": id});
      final decode = jsonDecode(response.body) as Map<String, dynamic>;

      return CommonResponseModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<UpcomingPaidSloteModel> getUpcomingSlotes() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.upcomingPaidSlotesUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;

      return UpcomingPaidSloteModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<CheckPaidClass> checkPaidClass(
      {required String classDate, required String slotId}) async {
    try {
      final response = await client.postWithProfile(
          url: AppUrls.checkPaidClassUrl,
          body: {"slote_id": slotId, "class_date": classDate});
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      return CheckPaidClass.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<CommonResponseModel> paidWebhook(
      {required PmPaidWebhook params}) async {
    try {
      final response = await client.postWithProfile(
          url: AppUrls.paidClassWebhookUrl, body: params.toJson());
      final decode = jsonDecode(response.body) as Map<String, dynamic>;

      return CommonResponseModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<CompletedNoteModel> getPaidClassNotes(
      {required String classId}) async {
    try {
      final response = await client.getWithProfile(
          url: "${AppUrls.paidClassNoteUrl}/$classId");
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      return CompletedNoteModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }
}
