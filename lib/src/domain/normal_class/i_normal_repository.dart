import 'package:music_app/src/domain/models/response_models/cancelled_class_model/cancelled_class_model.dart';
import 'package:music_app/src/domain/models/response_models/common_response_model/common_response_model.dart';
import 'package:music_app/src/domain/models/response_models/completed_class_model/completed_class_model.dart';
import 'package:music_app/src/domain/models/response_models/completed_note_model/completed_note_model.dart';
import 'package:music_app/src/domain/models/response_models/emergency_cancel_model/emergency_cancel_model.dart';
import 'package:music_app/src/domain/models/response_models/upcoming_class_model/upcoming_class_model.dart';

abstract class INormalClassRepository {
  Future<UpcomingClassModel> getUpcomingClass();
  Future<CommonResponseModel> cancelNormalClass(
      {required String date, required String reason});
  Future<CommonResponseModel> cancelMultipleClass(
      {required String fromDate,
      required String toDate,
      required String reason});
  Future<CancelledClassModel> getCancelledClass();
  Future<CompletedClassModel> getCompletedClass();
  Future<CompletedNoteModel> getCompletedNotes({required String classId});
  Future<EmergencyCancelModel> emergencyCancel(
      {required String date, required String reason});
}
