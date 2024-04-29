import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/domain/core/failures/api_auth_failure.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/models/pm_models/pm_get_fee_details_model/pm_get_fee_details_model.dart';
import 'package:music_app/src/domain/models/pm_models/pm_get_slote_model/pm_get_slote_model.dart';
import 'package:music_app/src/domain/models/pm_models/pm_slot_booking_model/pm_slot_booking_model.dart';
import 'package:music_app/src/domain/models/pm_models/pm_slote_book_webhook/pm_slote_book_webhook.dart';
import 'package:music_app/src/domain/models/response_models/fee_details_model/fee_details_model.dart';
import 'package:music_app/src/domain/models/response_models/plans_model/plan.dart';
import 'package:music_app/src/domain/models/response_models/slot_model/slote.dart';
import 'package:music_app/src/domain/slot_booking/i_slot_booking_repository.dart';

part 'slot_booking_event.dart';
part 'slot_booking_state.dart';

@injectable
class SlotBookingBloc extends Bloc<SlotBookingEvent, SlotBookingState> {
  SlotBookingBloc(this._iSlotBookingRepository)
      : super(const SlotBookingState()) {
    on<GetPlansEvent>(_getPlanList);
    on<GetSlotsEvent>(_getSlotList);
    on<GetFeeDetailsEvent>(_getFeeDetails);
    on<BookingSlotEvent>(_slotBooking);
    on<CleanFeeDetailsEvent>(_clean);
    on<SlotBookWebhookEvent>(_slotBookingWebhook);
  }
  FutureOr<void> _getPlanList(
      GetPlansEvent event, Emitter<SlotBookingState> emit) async {
    try {
      emit(state.copyWith(status: StatusLoading()));
      final res = await _iSlotBookingRepository.getPlans();
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

  FutureOr<void> _getSlotList(
      GetSlotsEvent event, Emitter<SlotBookingState> emit) async {
    try {
      emit(state.copyWith(status: StatusLoading()));
      final res = await _iSlotBookingRepository.getSlots(
          param: PmGetSloteModel(day: event.param));
      if (res.statusCode == '01') {
        emit(state.copyWith(status: StatusSuccess(), slotList: res.slotes));
      } else {
        emit(state.copyWith(status: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(status: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(status: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _getFeeDetails(
      GetFeeDetailsEvent event, Emitter<SlotBookingState> emit) async {
    try {
      emit(state.copyWith(feeDetailStatus: StatusLoading()));
      final res =
          await _iSlotBookingRepository.getFeeDetails(params: event.params);
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

  FutureOr<void> _slotBooking(
      BookingSlotEvent event, Emitter<SlotBookingState> emit) async {
    try {
      emit(state.copyWith(slotBookingStatus: StatusLoading()));
      final res =
          await _iSlotBookingRepository.slotBooking(params: event.params);
      if (res.statusCode == '01') {
        emit(state.copyWith(slotBookingStatus: StatusSuccess()));
      } else {
        emit(state.copyWith(
            slotBookingStatus: StatusFailure(res.message ?? "Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(slotBookingStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(slotBookingStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _clean(
      CleanFeeDetailsEvent event, Emitter<SlotBookingState> emit) {
    emit(state.copyWith(
        feeDetailStatus: const StatusInitial(),
        feeDetails: const FeeDetailsModel()));
  }

  FutureOr<void> _slotBookingWebhook(
      SlotBookWebhookEvent event, Emitter<SlotBookingState> emit) async {
    try {
      emit(state.copyWith(slotBookingWebhookStatus: StatusLoading()));
      final res =
          await _iSlotBookingRepository.bookSlotWebhook(params: event.params);
      if (res.statusCode == '01') {
        emit(state.copyWith(slotBookingWebhookStatus: StatusSuccess()));
      } else {
        emit(state.copyWith(
            slotBookingWebhookStatus:
                StatusFailure(res.message ?? "Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(slotBookingWebhookStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(
          slotBookingWebhookStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  final ISlotBookingRepository _iSlotBookingRepository;
}
