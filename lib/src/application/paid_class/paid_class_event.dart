part of 'paid_class_bloc.dart';

sealed class PaidClassEvent extends Equatable {
  const PaidClassEvent();

  @override
  List<Object> get props => [];
}

class GetPaidClassListEvent extends PaidClassEvent {
  const GetPaidClassListEvent();
  @override
  List<Object> get props => [];
}

class GetPaidClassSloteEvent extends PaidClassEvent {
  const GetPaidClassSloteEvent({required this.date});
  final String date;
  @override
  List<Object> get props => [date];
}

class BookPaidClassEvent extends PaidClassEvent {
  const BookPaidClassEvent(
      {required this.date,
      required this.paidAmount,
      required this.refernceId,
      required this.sloteId});
  final String date;
  final String paidAmount;
  final String sloteId;
  final String refernceId;
  @override
  List<Object> get props => [date, paidAmount, refernceId, sloteId];
}

class CancelPaidClassEvent extends PaidClassEvent {
  const CancelPaidClassEvent({required this.id, required this.reason});
  final String id;
  final String reason;
  @override
  List<Object> get props => [id, reason];
}

class UpcomingSloteEvent extends PaidClassEvent {
  const UpcomingSloteEvent();
  @override
  List<Object> get props => [];
}

class CheckPaidClassEvent extends PaidClassEvent {
  const CheckPaidClassEvent({required this.classDate, required this.slotId});
  final String classDate;
  final String slotId;
  @override
  List<Object> get props => [classDate, slotId];
}
