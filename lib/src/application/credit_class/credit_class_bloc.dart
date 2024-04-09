import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/domain/core/failures/api_auth_failure.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/credit_class/i_credit_class_repository.dart';
import 'package:music_app/src/domain/models/response_models/credit_class_model/credit_class.dart';
import 'package:music_app/src/domain/models/response_models/emergency_cancel_model/emergency_cancel_model.dart';
import 'package:music_app/src/domain/models/response_models/slot_model/slote.dart';
import 'package:music_app/src/domain/models/response_models/upcoming_slotes_model/dates_and_available_slote.dart';

part 'credit_class_event.dart';
part 'credit_class_state.dart';

@injectable
class CreditClassBloc extends Bloc<CreditClassEvent, CreditClassState> {
  CreditClassBloc(this._iCreditClassRepository)
      : super(const CreditClassState()) {
    on<GetCreditClassEvent>(_getCreditClass);
    on<GetSlotsEvent>(_getCreditClassSlote);
    on<BookCreditClassEvent>(_bookCreditClass);
    on<CancelCreditClassEvent>(_cancelCreditClass);
    on<EmergencyCancelEvent>(_emergencyCancelCredit);
    on<UpcomingCreditSloteEvent>(_getUpcomingSlotes);
  }
  FutureOr<void> _getCreditClass(
      GetCreditClassEvent event, Emitter<CreditClassState> emit) async {
    try {
      emit(state.copyWith(status: StatusLoading()));
      final res = await _iCreditClassRepository.getCreditClass();
      if (res.statusCode == '01') {
        emit(state.copyWith(
            status: StatusSuccess(), creditClasses: res.creditClasses));
      } else {
        emit(state.copyWith(status: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(status: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(status: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _getCreditClassSlote(
      GetSlotsEvent event, Emitter<CreditClassState> emit) async {
    try {
      emit(state.copyWith(slotStatus: StatusLoading()));
      final res =
          await _iCreditClassRepository.getCreditClassSlotes(date: event.date);
      if (res.statusCode == '01') {
        emit(state.copyWith(slotStatus: StatusSuccess(), slotList: res.slotes));
      } else {
        emit(state.copyWith(slotStatus: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(slotStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(slotStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _bookCreditClass(
      BookCreditClassEvent event, Emitter<CreditClassState> emit) async {
    try {
      emit(state.copyWith(bookStatus: StatusLoading()));
      final res = await _iCreditClassRepository.bookCreditClass(
          date: event.date, classId: event.classId, slotId: event.slotId);
      if (res.statusCode == '01') {
        emit(state.copyWith(bookStatus: StatusSuccess()));
      } else {
        emit(state.copyWith(
            bookStatus: StatusFailure(res.message ?? "Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(bookStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(bookStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _cancelCreditClass(
      CancelCreditClassEvent event, Emitter<CreditClassState> emit) async {
    try {
      emit(state.copyWith(cancelStatus: StatusLoading()));
      final res = await _iCreditClassRepository.cancelCreditClass(
          classId: event.id, reason: event.reason);
      if (res.statusCode == '01') {
        emit(state.copyWith(cancelStatus: StatusSuccess()));
      } else {
        emit(state.copyWith(
            cancelStatus: StatusFailure(res.message ?? "Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(cancelStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(cancelStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _emergencyCancelCredit(
      EmergencyCancelEvent event, Emitter<CreditClassState> emit) async {
    try {
      emit(state.copyWith(cancelStatus: StatusLoading()));
      final res = await _iCreditClassRepository.emergencyCancelClass(
          classId: event.id, reason: event.reason);
      if (res.statusCode == '01') {
        emit(state.copyWith(
            cancelStatus: StatusSuccess(), emergencyCancelData: res));
      } else {
        emit(state.copyWith(
            cancelStatus: StatusFailure(res.message ?? "Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(cancelStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(cancelStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _getUpcomingSlotes(
      UpcomingCreditSloteEvent event, Emitter<CreditClassState> emit) async {
    try {
      emit(state.copyWith(upcomingSlotStatus: StatusLoading()));
      final res = await _iCreditClassRepository.getUpcomingSlotes();
      if (res.statusCode == '01') {
        emit(state.copyWith(
            upcomingSlotStatus: StatusSuccess(),
            slotStatus: const StatusInitial(),
            dateAndSlotList: res.datesAndAvailableSlotes));
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

  final ICreditClassRepository _iCreditClassRepository;
}
