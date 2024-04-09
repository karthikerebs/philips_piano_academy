import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:music_app/src/domain/core/app_url/app_urls.dart';
import 'package:music_app/src/domain/core/failures/api_auth_failure.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/core/internet_service/i_base_client.dart';
import 'package:music_app/src/domain/models/pm_models/pm_get_fee_details_model/pm_get_fee_details_model.dart';
import 'package:music_app/src/domain/models/pm_models/pm_get_slote_model/pm_get_slote_model.dart';
import 'package:music_app/src/domain/models/pm_models/pm_slot_booking_model/pm_slot_booking_model.dart';
import 'package:music_app/src/domain/models/response_models/fee_details_model/fee_details_model.dart';
import 'package:music_app/src/domain/models/response_models/plans_model/plans_model.dart';
import 'package:music_app/src/domain/models/response_models/slot_booking_response_model/slot_booking_response_model.dart';
import 'package:music_app/src/domain/models/response_models/slot_model/slot_model.dart';
import 'package:music_app/src/domain/slot_booking/i_slot_booking_repository.dart';

@LazySingleton(as: ISlotBookingRepository)
class SlotBookingRepository extends ISlotBookingRepository {
  final IBaseClient client;

  SlotBookingRepository(this.client);

  @override
  Future<PlansModel> getPlans() async {
    try {
      final response = await client.getWithProfile(url: AppUrls.getPlansUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      if (decode['status_code'] == "01") {
        return PlansModel.fromJson(decode);
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
  Future<SlotModel> getSlots({required PmGetSloteModel param}) async {
    try {
      final response = await client.postWithProfile(
          url: AppUrls.getSlotsUrl, body: param.toJson());
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      if (decode['status_code'] == "01") {
        return SlotModel.fromJson(decode);
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
  Future<SlotBookingResponseModel> slotBooking(
      {required PmSlotBookingModel params}) async {
    try {
      final response = await client.postWithProfile(
          url: AppUrls.slotBookingUrl, body: params.toJson());
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      if (decode['status_code'] == "01") {
        return SlotBookingResponseModel.fromJson(decode);
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
  Future<FeeDetailsModel> getFeeDetails(
      {required PmGetFeeDetailsModel params}) async {
    try {
      final response = await client.postWithProfile(
          url: AppUrls.getFeeDetailsUrl, body: params.toJson());
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      if (decode['status_code'] == "01") {
        return FeeDetailsModel.fromJson(decode);
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
