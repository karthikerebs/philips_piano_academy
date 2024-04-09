import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/domain/core/failures/api_auth_failure.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/models/response_models/cancelled_class_model/cancelled_class.dart';
import 'package:music_app/src/domain/models/response_models/completed_class_model/completed_class.dart';
import 'package:music_app/src/domain/models/response_models/completed_note_model/completed_note_model.dart';
import 'package:music_app/src/domain/models/response_models/emergency_cancel_model/emergency_cancel_model.dart';
import 'package:music_app/src/domain/models/response_models/upcoming_class_model/upcoming_class.dart';
import 'package:music_app/src/domain/normal_class/i_normal_repository.dart';

part 'normal_class_event.dart';
part 'normal_class_state.dart';

@injectable
class NormalClassBloc extends Bloc<NormalClassEvent, NormalClassState> {
  NormalClassBloc(this._iNormalClassRepository)
      : super(const NormalClassState()) {
    on<UpcomingClassEvent>(_getUpcomingClass);
    on<CancelClassEvent>(_cancelNormalClass);
    on<CancelMulitpleClassEvent>(_cancelMulitpleClass);
    on<GetCanceledClassEvent>(_getCanceledClass);
    on<CompletedClassEvent>(_getCompletedClass);
    on<GetCompletedClassNoteEvent>(_getCompletedNotes);
    on<EmergencyCancelEvent>(_emergencyCancelClass);
  }
  FutureOr<void> _getUpcomingClass(
      UpcomingClassEvent event, Emitter<NormalClassState> emit) async {
    try {
      emit(state.copyWith(upcomingClassStatus: StatusLoading()));
      final res = await _iNormalClassRepository.getUpcomingClass();
      if (res.statusCode == '01') {
        emit(state.copyWith(
          upcomingClassStatus: StatusSuccess(),
          upcomingClassList: res.upcomingClasses,
        ));
      } else {
        emit(state.copyWith(
            upcomingClassStatus: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(upcomingClassStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(
          upcomingClassStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _cancelNormalClass(
      CancelClassEvent event, Emitter<NormalClassState> emit) async {
    try {
      emit(state.copyWith(status: StatusLoading()));
      final res = await _iNormalClassRepository.cancelNormalClass(
          date: event.date, reason: event.reason);
      if (res.statusCode == '01') {
        emit(state.copyWith(status: StatusSuccess()));
      } else {
        emit(state.copyWith(status: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(status: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(status: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _cancelMulitpleClass(
      CancelMulitpleClassEvent event, Emitter<NormalClassState> emit) async {
    try {
      emit(state.copyWith(status: StatusLoading()));
      final res = await _iNormalClassRepository.cancelMultipleClass(
          fromDate: event.fromDate, reason: event.reason, toDate: event.toDate);
      if (res.statusCode == '00') {
        emit(state.copyWith(status: StatusSuccess()));
      } else {
        emit(state.copyWith(status: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(status: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(status: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _getCanceledClass(
      GetCanceledClassEvent event, Emitter<NormalClassState> emit) async {
    try {
      emit(state.copyWith(cancelClassStatus: StatusLoading()));
      final res = await _iNormalClassRepository.getCancelledClass();
      if (res.statusCode == '01') {
        emit(state.copyWith(
            cancelClassStatus: StatusSuccess(),
            cancelledClassList: res.cancelledClasses));
      } else {
        emit(state.copyWith(
            cancelClassStatus: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(status: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(status: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _getCompletedClass(
      CompletedClassEvent event, Emitter<NormalClassState> emit) async {
    try {
      emit(state.copyWith(completedClassStatus: StatusLoading()));
      final res = await _iNormalClassRepository.getCompletedClass();
      if (res.statusCode == '01') {
        emit(state.copyWith(
            completedClassStatus: StatusSuccess(),
            completedClassList: res.completedClasses));
      } else {
        emit(state.copyWith(
            completedClassStatus: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(completedClassStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(
          completedClassStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _getCompletedNotes(
      GetCompletedClassNoteEvent event, Emitter<NormalClassState> emit) async {
    try {
      emit(state.copyWith(status: StatusLoading()));
      final res = await _iNormalClassRepository.getCompletedNotes(
          classId: event.classId);
      if (res.statusCode == '01') {
        emit(state.copyWith(status: StatusSuccess(), completedClassNote: res));
      } else {
        emit(state.copyWith(status: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(status: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(status: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _emergencyCancelClass(
      EmergencyCancelEvent event, Emitter<NormalClassState> emit) async {
    try {
      emit(state.copyWith(status: StatusLoading()));
      final res = await _iNormalClassRepository.emergencyCancel(
          date: event.date, reason: event.reason);
      if (res.statusCode == '01') {
        emit(state.copyWith(status: StatusSuccess(), emergencyCancelData: res));
      } else {
        emit(state.copyWith(status: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(status: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(status: StatusAuthFailure(e.error ?? "")));
    }
  }

  final INormalClassRepository _iNormalClassRepository;
}
