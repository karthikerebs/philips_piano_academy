import 'dart:convert';
import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:music_app/src/domain/core/app_url/app_urls.dart';
import 'package:music_app/src/domain/core/failures/api_auth_failure.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/core/internet_service/i_base_client.dart';
import 'package:music_app/src/domain/models/response_models/cancelled_class_model/cancelled_class_model.dart';
import 'package:music_app/src/domain/models/response_models/common_response_model/common_response_model.dart';
import 'package:music_app/src/domain/models/response_models/completed_class_model/completed_class_model.dart';
import 'package:music_app/src/domain/models/response_models/completed_note_model/completed_note_model.dart';
import 'package:music_app/src/domain/models/response_models/emergency_cancel_model/emergency_cancel_model.dart';
import 'package:music_app/src/domain/models/response_models/upcoming_class_model/upcoming_class_model.dart';
import 'package:music_app/src/domain/normal_class/i_normal_repository.dart';

@LazySingleton(as: INormalClassRepository)
class NormalClassRepository extends INormalClassRepository {
  final IBaseClient client;

  NormalClassRepository(this.client);
  @override
  Future<UpcomingClassModel> getUpcomingClass() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.getUpcomingNormalClassUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      return UpcomingClassModel.fromJson(decode);
    } on ApiFailure catch (e) {
      log("qwertyu");
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<CommonResponseModel> cancelNormalClass(
      {required String date, required String reason}) async {
    try {
      final response = await client.postWithProfile(
          url: AppUrls.cancelNormalClassUrl,
          body: {"class_date": date, "reason": reason});
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      return CommonResponseModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<CommonResponseModel> cancelMultipleClass(
      {required String fromDate,
      required String toDate,
      required String reason}) async {
    try {
      final response = await client.postWithProfile(
          url: AppUrls.cancelMultipleClassUrl,
          body: {"from_date": fromDate, "to_date": toDate, "reason": reason});
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      return CommonResponseModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<CancelledClassModel> getCancelledClass() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.getCancelledClassUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      return CancelledClassModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<CompletedClassModel> getCompletedClass() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.getCompletedClassUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;

      return CompletedClassModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<CompletedNoteModel> getCompletedNotes(
      {required String classId}) async {
    try {
      final response = await client.getWithProfile(
          url: "${AppUrls.getCompletedClassNoteUrl}/$classId");
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      return CompletedNoteModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<EmergencyCancelModel> emergencyCancel(
      {required String date, required String reason}) async {
    try {
      final response = await client.postWithProfile(
          url: AppUrls.emergencyCancelUrl,
          body: {"class_date": date, "reason": reason});
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      return EmergencyCancelModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }
}
