import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/domain/core/failures/api_auth_failure.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/models/response_models/check_paid_class/check_paid_class.dart';
import 'package:music_app/src/domain/models/response_models/paid_class_slot_model/paid_class_slot_model.dart';
import 'package:music_app/src/domain/models/response_models/piad_class_model/paid_class.dart';
import 'package:music_app/src/domain/paid_class/i_paid_class_repository.dart';

import '../../domain/models/response_models/upcoming_paid_slote_model/upcoming_paid_slote_model.dart';

part 'paid_class_event.dart';
part 'paid_class_state.dart';

@injectable
class PaidClassBloc extends Bloc<PaidClassEvent, PaidClassState> {
  PaidClassBloc(this._iPaidClassRepository) : super(const PaidClassState()) {
    on<GetPaidClassSloteEvent>(_getPaidClassSloteList);
    on<BookPaidClassEvent>(_bookPaidClass);
    on<GetPaidClassListEvent>(_getPaidClassList);
    on<CancelPaidClassEvent>(_cancelPaidClass);
    on<UpcomingSloteEvent>(_getUpcomingSlotes);
    on<CheckPaidClassEvent>(_checkPaidClass);
  }
  FutureOr<void> _getPaidClassList(
      GetPaidClassListEvent event, Emitter<PaidClassState> emit) async {
    try {
      emit(state.copyWith(status: StatusLoading()));
      final res = await _iPaidClassRepository.getAllPaidClass();
      if (res.statusCode == '01') {
        emit(state.copyWith(
            status: StatusSuccess(), paidClassList: res.paidClasses));
      } else {
        emit(state.copyWith(status: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(status: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(status: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _getPaidClassSloteList(
      GetPaidClassSloteEvent event, Emitter<PaidClassState> emit) async {
    try {
      emit(state.copyWith(slotStatus: StatusLoading()));
      final res =
          await _iPaidClassRepository.getPaidClassSlotes(date: event.date);
      if (res.statusCode == '01') {
        emit(state.copyWith(slotStatus: StatusSuccess(), slotDetails: res));
      } else {
        emit(state.copyWith(slotStatus: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(slotStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(slotStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _bookPaidClass(
      BookPaidClassEvent event, Emitter<PaidClassState> emit) async {
    try {
      emit(state.copyWith(bookStatus: StatusLoading()));
      final res = await _iPaidClassRepository.bookPaidClass(
          classDate: event.date,
          paidAmount: event.paidAmount,
          referenceId: event.refernceId,
          sloteId: event.sloteId);
      if (res.statusCode == '01') {
        emit(state.copyWith(bookStatus: StatusSuccess()));
      } else {
        emit(state.copyWith(bookStatus: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(bookStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(bookStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _cancelPaidClass(
      CancelPaidClassEvent event, Emitter<PaidClassState> emit) async {
    try {
      emit(state.copyWith(cancelStatus: StatusLoading()));
      final res = await _iPaidClassRepository.cancelPaidClass(
          id: event.id, reason: event.reason);
      if (res.statusCode == '01') {
        emit(state.copyWith(cancelStatus: StatusSuccess()));
      } else {
        emit(state.copyWith(cancelStatus: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(cancelStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(cancelStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _getUpcomingSlotes(
      UpcomingSloteEvent event, Emitter<PaidClassState> emit) async {
    try {
      emit(state.copyWith(upcomingSlotStatus: StatusLoading()));
      final res = await _iPaidClassRepository.getUpcomingSlotes();
      if (res.statusCode == '01') {
        emit(state.copyWith(
          upcomingSlotStatus: StatusSuccess(),
          slotStatus: const StatusInitial(),
          paidSloteDetails: res,
        ));
      } else {
        emit(state.copyWith(
            upcomingSlotStatus: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(upcomingSlotStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(
          state.copyWith(upcomingSlotStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _checkPaidClass(
      CheckPaidClassEvent event, Emitter<PaidClassState> emit) async {
    try {
      emit(state.copyWith(checkPaidStatus: StatusLoading()));
      final res = await _iPaidClassRepository.checkPaidClass(
          classDate: event.classDate, slotId: event.slotId);
      if (res.statusCode == '01') {
        emit(state.copyWith(
            checkPaidStatus: StatusSuccess(), checPaidClassData: res));
      } else {
        log("////////////");
        emit(state.copyWith(
            checkPaidStatus: StatusFailure(res.message ?? "Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(checkPaidStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(checkPaidStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  final IPaidClassRepository _iPaidClassRepository;
}
