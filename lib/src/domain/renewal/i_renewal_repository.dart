import 'package:music_app/src/domain/models/pm_models/pm_send_renew_request_model/pm_send_renew_request_model.dart';
import 'package:music_app/src/domain/models/response_models/check_renewal_response/check_renewal_response.dart';
import 'package:music_app/src/domain/models/response_models/common_response_model/common_response_model.dart';
import 'package:music_app/src/domain/models/response_models/get_renewal_fees_model/get_renewal_fees_model.dart';
import 'package:music_app/src/domain/models/response_models/plans_model/plans_model.dart';
import 'package:music_app/src/domain/models/response_models/renewal_fee_details/renewal_fee_details.dart';

abstract class IRenewalRepository {
  Future<RenewalFeeDetails> getRenewalFeeDetails({required String months});
  Future<PlansModel> getPlans();
  Future<CommonResponseModel> sendRenewalRequest(
      {required PmSendRenewRequestModel params});
  Future<GetRenewalFeesModel> getRenewalFees();
  Future<CheckRenewalResponse> checkRenewal();
}
