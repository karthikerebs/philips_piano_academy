import 'package:music_app/src/domain/models/response_models/common_response_model/common_response_model.dart';
import 'package:music_app/src/domain/models/response_models/refund_request_model/refund_request_model.dart';

abstract class IRefundRequestRepository {
  Future<RefundRequestModel> getRefundRequests();
  Future<CommonResponseModel> sendRefundRequests(
      {required String date, required String reason});
}
