import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/domain/core/failures/api_auth_failure.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/models/pm_models/pm_renewal_webhook/pm_renewal_webhook.dart';
import 'package:music_app/src/domain/models/pm_models/pm_send_renew_request_model/pm_send_renew_request_model.dart';
import 'package:music_app/src/domain/models/response_models/get_renewal_fees_model/get_renewal_fees_model.dart';
import 'package:music_app/src/domain/models/response_models/plans_model/plan.dart';
import 'package:music_app/src/domain/models/response_models/renewal_fee_details/renewal_fee_details.dart';
import 'package:music_app/src/domain/renewal/i_renewal_repository.dart';

part 'renewal_event.dart';
part 'renewal_state.dart';

@injectable
class RenewalBloc extends Bloc<RenewalEvent, RenewalState> {
  RenewalBloc(this._iRenewalRepository) : super(const RenewalState()) {
    on<GetRenewalPlansEvent>(_getRenewalPlans);
    on<GetRenewalFeeDetailsEvent>(_getRenewalFeeDetails);
    on<SendRenewalRequestEvent>(_sendRenewalRequest);
    on<CleanDataEvent>(_clean);
    on<GetRenewalFeesEvent>(_getRenewalFees);
    on<CheckRenewalEvent>(_checkRequestRenewal);
    on<RenewalWebhookEvent>(_renewalWebhook);
  }
  FutureOr<void> _getRenewalPlans(
      GetRenewalPlansEvent event, Emitter<RenewalState> emit) async {
    try {
      emit(state.copyWith(status: StatusLoading()));
      final res = await _iRenewalRepository.getPlans();
      if (res.statusCode == '01') {
        emit(state.copyWith(status: StatusSuccess(), planList: res.plans));
      } else {
        emit(state.copyWith(status: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(status: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(status: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _getRenewalFeeDetails(
      GetRenewalFeeDetailsEvent event, Emitter<RenewalState> emit) async {
    try {
      emit(state.copyWith(feeDetailStatus: StatusLoading()));
      final res =
          await _iRenewalRepository.getRenewalFeeDetails(months: event.months);
      if (res.statusCode == '01') {
        emit(state.copyWith(feeDetailStatus: StatusSuccess(), feeDetails: res));
      } else {
        emit(state.copyWith(
            feeDetailStatus: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(feeDetailStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(feeDetailStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _sendRenewalRequest(
      SendRenewalRequestEvent event, Emitter<RenewalState> emit) async {
    try {
      emit(state.copyWith(requestStatus: StatusLoading()));
      final res =
          await _iRenewalRepository.sendRenewalRequest(params: event.params);
      if (res.statusCode == '01') {
        emit(state.copyWith(requestStatus: StatusSuccess()));
      } else {
        emit(
            state.copyWith(requestStatus: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      if (e.message == "Instance of 'ApiFailure'") {
        emit(state.copyWith(
            requestStatus: StatusFailure("Request already sent")));
      } else {
        emit(state.copyWith(requestStatus: StatusFailure(e.message)));
      }
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(requestStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _clean(CleanDataEvent event, Emitter<RenewalState> emit) {
    emit(state.copyWith(
        feeDetailStatus: const StatusInitial(),
        feeDetails: const RenewalFeeDetails()));
  }

  FutureOr<void> _getRenewalFees(
      GetRenewalFeesEvent event, Emitter<RenewalState> emit) async {
    try {
      emit(state.copyWith(status: StatusLoading()));
      final res = await _iRenewalRepository.getRenewalFees();
      if (res.statusCode == '01') {
        emit(state.copyWith(status: StatusSuccess(), renewalFees: res));
      } else {
        emit(state.copyWith(status: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(status: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(status: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _checkRequestRenewal(
      CheckRenewalEvent event, Emitter<RenewalState> emit) async {
    try {
      emit(state.copyWith(checkRenewalStatus: StatusLoading()));
      final res = await _iRenewalRepository.checkRenewal();
      if (res.statusCode == '01') {
        emit(state.copyWith(checkRenewalStatus: StatusSuccess()));
      } else {
        emit(state.copyWith(
            checkRenewalStatus: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(checkRenewalStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(
          state.copyWith(checkRenewalStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _renewalWebhook(
      RenewalWebhookEvent event, Emitter<RenewalState> emit) async {
    try {
      emit(state.copyWith(renewalWebhookStatus: StatusLoading()));
      final res =
          await _iRenewalRepository.renewalWebhook(params: event.params);
      if (res.statusCode == '01') {
        emit(state.copyWith(renewalWebhookStatus: StatusSuccess()));
      } else {
        emit(state.copyWith(
            renewalWebhookStatus: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(renewalWebhookStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(
          renewalWebhookStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  final IRenewalRepository _iRenewalRepository;
}
