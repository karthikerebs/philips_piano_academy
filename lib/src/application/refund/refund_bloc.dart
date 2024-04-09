import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/domain/core/failures/api_auth_failure.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/models/response_models/refund_request_model/refund_request.dart';
import 'package:music_app/src/domain/refund_request/i_refund_repository.dart';

part 'refund_event.dart';
part 'refund_state.dart';

@injectable
class RefundBloc extends Bloc<RefundEvent, RefundState> {
  RefundBloc(this._iRefundRequestRepository) : super(const RefundState()) {
    on<GetRefundRequestsEvent>(_getRefundRequestsList);
    on<SendRefundRequestsEvent>(_sendRefundRequestsList);
  }
  FutureOr<void> _getRefundRequestsList(
      GetRefundRequestsEvent event, Emitter<RefundState> emit) async {
    try {
      emit(state.copyWith(status: StatusLoading()));
      final res = await _iRefundRequestRepository.getRefundRequests();
      if (res.statusCode == '01') {
        emit(state.copyWith(
            status: StatusSuccess(), refundRequestList: res.refundRequests));
      } else {
        emit(state.copyWith(status: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(status: StatusAuthFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(status: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _sendRefundRequestsList(
      SendRefundRequestsEvent event, Emitter<RefundState> emit) async {
    try {
      emit(state.copyWith(sendRequestStatus: StatusLoading()));
      final res = await _iRefundRequestRepository.sendRefundRequests(
          date: event.leavingDate, reason: event.reason);
      if (res.statusCode == '01') {
        emit(state.copyWith(sendRequestStatus: StatusSuccess()));
      } else {
        emit(state.copyWith(
            sendRequestStatus: StatusFailure(res.message ?? "Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(sendRequestStatus: StatusAuthFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(sendRequestStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  final IRefundRequestRepository _iRefundRequestRepository;
}
