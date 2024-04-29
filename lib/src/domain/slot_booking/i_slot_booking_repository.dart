import 'package:music_app/src/domain/models/pm_models/pm_get_fee_details_model/pm_get_fee_details_model.dart';

import 'package:music_app/src/domain/models/pm_models/pm_get_slote_model/pm_get_slote_model.dart';

import 'package:music_app/src/domain/models/pm_models/pm_slot_booking_model/pm_slot_booking_model.dart';

import 'package:music_app/src/domain/models/pm_models/pm_slote_book_webhook/pm_slote_book_webhook.dart';

import 'package:music_app/src/domain/models/response_models/common_response_model/common_response_model.dart';

import 'package:music_app/src/domain/models/response_models/fee_details_model/fee_details_model.dart';

import 'package:music_app/src/domain/models/response_models/plans_model/plans_model.dart';

import 'package:music_app/src/domain/models/response_models/slot_booking_response_model/slot_booking_response_model.dart';

import 'package:music_app/src/domain/models/response_models/slot_model/slot_model.dart';

abstract class ISlotBookingRepository {
  Future<PlansModel> getPlans();

  Future<SlotModel> getSlots({required PmGetSloteModel param});

  Future<SlotBookingResponseModel> slotBooking(
      {required PmSlotBookingModel params});

  Future<FeeDetailsModel> getFeeDetails({required PmGetFeeDetailsModel params});

  Future<CommonResponseModel> bookSlotWebhook(
      {required PmSloteBookWebhook params});
}
