import 'package:music_app/src/domain/models/pm_models/pm_paid_webhook/pm_paid_webhook.dart';
import 'package:music_app/src/domain/models/response_models/check_paid_class/check_paid_class.dart';
import 'package:music_app/src/domain/models/response_models/common_response_model/common_response_model.dart';
import 'package:music_app/src/domain/models/response_models/completed_note_model/completed_note_model.dart';
import 'package:music_app/src/domain/models/response_models/paid_class_slot_model/paid_class_slot_model.dart';
import 'package:music_app/src/domain/models/response_models/piad_class_model/piad_class_model.dart';
import 'package:music_app/src/domain/models/response_models/upcoming_paid_slote_model/upcoming_paid_slote_model.dart';

abstract class IPaidClassRepository {
  Future<PaidClassSlotModel> getPaidClassSlotes({required String date});
  Future<CommonResponseModel> bookPaidClass(
      {required String sloteId,
      required String classDate,
      required String paidAmount,
      required String referenceId});
  Future<PiadClassModel> getAllPaidClass();
  Future<CommonResponseModel> cancelPaidClass(
      {required String reason, required String id});
  Future<UpcomingPaidSloteModel> getUpcomingSlotes();
  Future<CheckPaidClass> checkPaidClass(
      {required String classDate, required String slotId});
  Future<CommonResponseModel> paidWebhook({required PmPaidWebhook params});
  Future<CompletedNoteModel> getPaidClassNotes({required String classId});
}
