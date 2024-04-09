import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:music_app/src/domain/core/app_url/app_urls.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/core/internet_service/i_base_client.dart';
import 'package:music_app/src/domain/installment/i_installment_repository.dart';
import 'package:music_app/src/domain/models/response_models/common_response_model/common_response_model.dart';
import 'package:music_app/src/domain/models/response_models/installment_model/installment_model.dart';
import 'package:music_app/src/domain/models/response_models/payment_installment_model/payment_installment_model.dart';

@LazySingleton(as: IInstallmentRepository)
class InstallmentRepository extends IInstallmentRepository {
  final IBaseClient client;

  InstallmentRepository(this.client);

  @override
  Future<InstallmentModel> getInstallements() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.getInstallmentsUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      if (decode['status_code'] == "01") {
        return InstallmentModel.fromJson(decode);
      } else {
        throw ApiFailure(message: decode['message']);
      }
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }

  @override
  Future<CommonResponseModel> payInstallments(
      {required String installmentId,
      required String paidAmount,
      required String referenceId}) async {
    try {
      final response =
          await client.postWithProfile(url: AppUrls.payInstallmentUrl, body: {
        "installment_id": installmentId,
        "paid_amount": paidAmount,
        "reference_id": referenceId
      });
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      if (decode['status_code'] == "01") {
        return CommonResponseModel.fromJson(decode);
      } else {
        throw ApiFailure(message: decode['message']);
      }
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }

  @override
  Future<PaymentInstallmentModel> getPendingInstallments() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.getPendingInstallmentsUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      return PaymentInstallmentModel.fromJson(decode);
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}
