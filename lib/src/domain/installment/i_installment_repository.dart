import 'package:music_app/src/domain/models/response_models/common_response_model/common_response_model.dart';
import 'package:music_app/src/domain/models/response_models/installment_model/installment_model.dart';
import 'package:music_app/src/domain/models/response_models/payment_installment_model/payment_installment_model.dart';

abstract class IInstallmentRepository {
  Future<InstallmentModel> getInstallements();
  Future<CommonResponseModel> payInstallments(
      {required String installmentId,
      required String paidAmount,
      required String referenceId});
  Future<PaymentInstallmentModel> getPendingInstallments();
}
