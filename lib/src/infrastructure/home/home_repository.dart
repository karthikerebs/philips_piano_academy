import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:music_app/src/domain/core/app_url/app_urls.dart';
import 'package:music_app/src/domain/core/failures/api_auth_failure.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/core/internet_service/i_base_client.dart';
import 'package:music_app/src/domain/home/i_home_repository.dart';
import 'package:music_app/src/domain/models/response_models/blog_model/blog_model.dart';
import 'package:music_app/src/domain/models/response_models/get_payment_status_model/get_payment_status_model.dart';
import 'package:music_app/src/domain/models/response_models/home_data_model/home_data_model.dart';
import 'package:music_app/src/domain/models/response_models/notification_model/notification_model.dart';
import 'package:music_app/src/domain/models/response_models/tutorial_video_model/tutorial_video_model.dart';

@LazySingleton(as: IHomeRepository)
class HomeRepository extends IHomeRepository {
  final IBaseClient client;

  HomeRepository(this.client);

  @override
  Future<BlogModel> getBlogsData() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.getBlogsDataUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      return BlogModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<TutorialVideoModel> getTutorialVideos() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.getVideosDataUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      return TutorialVideoModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<HomeDataModel> getHomeData() async {
    try {
      final response = await client.getWithProfile(url: AppUrls.getHomeDataUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      return HomeDataModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<NotificationModel> getNotifications() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.getNotificationsUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      return NotificationModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }

  @override
  Future<GetPaymentStatusModel> getPaymentStatus() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.getPaymentStatusUrl);
      final decode = jsonDecode(response.data);
      return GetPaymentStatusModel.fromJson(decode);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.toString());
    } on ApiAuthFailure catch (e) {
      throw ApiAuthFailure(e.error ?? "");
    }
  }
}
