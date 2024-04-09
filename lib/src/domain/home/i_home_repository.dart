import 'package:music_app/src/domain/models/response_models/blog_model/blog_model.dart';
import 'package:music_app/src/domain/models/response_models/home_data_model/home_data_model.dart';
import 'package:music_app/src/domain/models/response_models/notification_model/notification_model.dart';
import 'package:music_app/src/domain/models/response_models/tutorial_video_model/tutorial_video_model.dart';

import '../models/response_models/get_payment_status_model/get_payment_status_model.dart';

abstract class IHomeRepository {
  Future<BlogModel> getBlogsData();
  Future<TutorialVideoModel> getTutorialVideos();
  Future<HomeDataModel> getHomeData();
  Future<NotificationModel> getNotifications();
  Future<GetPaymentStatusModel> getPaymentStatus();
}
