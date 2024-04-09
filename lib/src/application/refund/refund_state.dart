part of 'refund_bloc.dart';

class RefundState extends Equatable {
  const RefundState(
      {this.status = const StatusInitial(),
      this.refundRequestList = const <RefundRequest>[],
      this.sendRequestStatus = const StatusInitial()});
  final Status status;
  final List<RefundRequest> refundRequestList;
  final Status sendRequestStatus;
  @override
  List<Object> get props => [status, refundRequestList, sendRequestStatus];
  RefundState copyWith(
      {Status? status,
      List<RefundRequest>? refundRequestList,
      Status? sendRequestStatus}) {
    return RefundState(
        status: status ?? this.status,
        refundRequestList: refundRequestList ?? this.refundRequestList,
        sendRequestStatus: sendRequestStatus ?? this.sendRequestStatus);
  }
}
