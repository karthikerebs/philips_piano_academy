import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/installment/i_installment_repository.dart';
import 'package:music_app/src/domain/models/response_models/installment_model/installment.dart';
import 'package:music_app/src/domain/models/response_models/payment_installment_model/installment.dart';
part 'installment_event.dart';
part 'installment_state.dart';

@injectable
class InstallmentBloc extends Bloc<InstallmentEvent, InstallmentState> {
  InstallmentBloc(this._iInstallmentRepository)
      : super(const InstallmentState()) {
    on<GetInstallmentListEvent>(_getInstallmentList);
    on<GetPendingInstallmentListEvent>(_getPendingInstallmentList);
  }
  FutureOr<void> _getInstallmentList(
      GetInstallmentListEvent event, Emitter<InstallmentState> emit) async {
    try {
      emit(state.copyWith(status: StatusLoading()));
      final res = await _iInstallmentRepository.getInstallements();
      if (res.statusCode == '01') {
        emit(state.copyWith(
            status: StatusSuccess(), installmentList: res.installments));
      } else {
        emit(state.copyWith(status: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      log(e.message);
      emit(state.copyWith(status: StatusAuthFailure(e.message)));
    }
  }

  FutureOr<void> _getPendingInstallmentList(
      GetPendingInstallmentListEvent event,
      Emitter<InstallmentState> emit) async {
    try {
      emit(state.copyWith(pendingstatus: StatusLoading()));
      final res = await _iInstallmentRepository.getPendingInstallments();
      if (res.statusCode == '01') {
        emit(state.copyWith(
            pendingstatus: StatusSuccess(),
            pendingInstallment: res.installments));
      } else {
        log("qwertyu");
        emit(
            state.copyWith(pendingstatus: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      log(e.message);
      emit(state.copyWith(pendingstatus: StatusAuthFailure(e.message)));
    }
  }

  final IInstallmentRepository _iInstallmentRepository;
}
