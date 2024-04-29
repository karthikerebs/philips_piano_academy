import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:music_app/src/domain/core/app_url/app_urls.dart';
import 'package:music_app/src/domain/core/failures/api_auth_failure.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/core/internet_service/i_base_client.dart';
import 'package:music_app/src/domain/models/pm_models/pm_edit_profile_model/pm_edit_profile_model.dart';
import 'package:music_app/src/domain/models/response_models/activity_model/activity_model.dart';
import 'package:music_app/src/domain/models/response_models/basic_details_model/basic_details_model.dart';
import 'package:music_app/src/domain/models/response_models/common_response_model/common_response_model.dart';
import 'package:music_app/src/domain/models/response_models/notification_count_model/notification_count_model.dart';
import 'package:music_app/src/domain/models/response_models/profile_model/profile_model.dart';
import 'package:music_app/src/domain/models/response_models/receipts_model/receipts_model.dart';
import 'package:music_app/src/domain/profile/i_profile_repository.dart';

@LazySingleton(as: IProfileRepository)
class ProfileRepository extends IProfileRepository {
  final IBaseClient client;

  ProfileRepository(this.client);
  @override
  Future<ProfileModel> getProfileData() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.getProfileDataUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      print(response.data);
      return ProfileModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<CommonResponseModel> editProfile(
      {required PmEditProfileModel params}) async {
    try {
      final response = await client.postWithProfile(
          url: AppUrls.updateProfileUrl, body: params.toJson());
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      return CommonResponseModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<CommonResponseModel> uploadImage({required String filePath}) async {
    try {
      final response = await client.mediaUpload(
          url: AppUrls.updateImageUrl, filePath: filePath, field: 'photo');
      final decode = jsonDecode(response.body) as Map<String, dynamic>;

      return CommonResponseModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<CommonResponseModel> changePassword({required String password}) async {
    try {
      final response = await client.postWithProfile(
          url: AppUrls.changePasswordUrl, body: {"password": password});
      final decode = jsonDecode(response.body) as Map<String, dynamic>;

      return CommonResponseModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<ActivityModel> getActivitiesData() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.getActivitiesDataUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      return ActivityModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<NotificationCountModel> getNotificationCount() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.getNotificationCountUrl);
      final decode = jsonDecode(response.data);
      return NotificationCountModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<ReceiptsModel> getReceipts() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.getRecieptesUrl);
      final decode = jsonDecode(response.data);
      return ReceiptsModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<BasicDetailsModel> getBasicDetails() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.getBasicDetailsUrl);
      final decode = jsonDecode(response.data);
      return BasicDetailsModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }
}
