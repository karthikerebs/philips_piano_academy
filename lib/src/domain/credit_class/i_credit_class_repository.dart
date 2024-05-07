import 'package:music_app/src/domain/models/response_models/common_response_model/common_response_model.dart';
import 'package:music_app/src/domain/models/response_models/completed_note_model/completed_note_model.dart';
import 'package:music_app/src/domain/models/response_models/credit_class_model/credit_class_model.dart';
import 'package:music_app/src/domain/models/response_models/emergency_cancel_model/emergency_cancel_model.dart';
import 'package:music_app/src/domain/models/response_models/slot_model/slot_model.dart';
import 'package:music_app/src/domain/models/response_models/upcoming_slotes_model/upcoming_slotes_model.dart';

abstract class ICreditClassRepository {
  Future<CreditClassModel> getCreditClass();
  Future<SlotModel> getCreditClassSlotes({required String date});
  Future<CommonResponseModel> bookCreditClass(
      {required String date, required String classId, required String slotId});
  Future<CommonResponseModel> cancelCreditClass(
      {required String classId, required String reason});
  Future<EmergencyCancelModel> emergencyCancelClass(
      {required String classId, required String reason});
  // Future<UpcomingSlotesModel> getUpcomingSlotes();
  Future<UpcomingSlotesModel> getUpcomingSlotes();
  Future<CompletedNoteModel> getCreditClassNotes({required String classId});
}
