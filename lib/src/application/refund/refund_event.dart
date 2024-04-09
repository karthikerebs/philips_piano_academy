part of 'refund_bloc.dart';

sealed class RefundEvent extends Equatable {
  const RefundEvent();

  @override
  List<Object> get props => [];
}

class GetRefundRequestsEvent extends RefundEvent {
  const GetRefundRequestsEvent();
  @override
  List<Object> get props => [];
}

class SendRefundRequestsEvent extends RefundEvent {
  const SendRefundRequestsEvent(
      {required this.leavingDate, required this.reason});
  final String leavingDate;
  final String reason;
  @override
  List<Object> get props => [leavingDate, reason];
}
