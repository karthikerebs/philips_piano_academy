import 'package:music_app/src/domain/models/pm_models/pm_edit_profile_model/pm_edit_profile_model.dart';
import 'package:music_app/src/domain/models/response_models/activity_model/activity_model.dart';
import 'package:music_app/src/domain/models/response_models/basic_details_model/basic_details_model.dart';
import 'package:music_app/src/domain/models/response_models/common_response_model/common_response_model.dart';
import 'package:music_app/src/domain/models/response_models/notification_count_model/notification_count_model.dart';
import 'package:music_app/src/domain/models/response_models/profile_model/profile_model.dart';

import '../models/response_models/receipts_model/receipts_model.dart';

abstract class IProfileRepository {
  Future<ProfileModel> getProfileData();
  Future<CommonResponseModel> editProfile({required PmEditProfileModel params});
  Future<CommonResponseModel> uploadImage({required String filePath});
  Future<CommonResponseModel> changePassword({required String password});
  Future<ActivityModel> getActivitiesData();
  Future<NotificationCountModel> getNotificationCount();
  Future<ReceiptsModel> getReceipts();
  Future<BasicDetailsModel> getBasicDetails();
}
