part of 'credit_class_bloc.dart';

sealed class CreditClassEvent extends Equatable {
  const CreditClassEvent();

  @override
  List<Object> get props => [];
}

class GetCreditClassEvent extends CreditClassEvent {
  const GetCreditClassEvent();

  @override
  List<Object> get props => [];
}

class GetSlotsEvent extends CreditClassEvent {
  const GetSlotsEvent(this.branchId, {required this.date});
  final String date;
  final String branchId;
  @override
  List<Object> get props => [date, branchId];
}

class BookCreditClassEvent extends CreditClassEvent {
  const BookCreditClassEvent(
      {required this.date, required this.classId, required this.slotId});
  final String date;
  final String classId;
  final String slotId;
  @override
  List<Object> get props => [date, classId, slotId];
}

class CancelCreditClassEvent extends CreditClassEvent {
  const CancelCreditClassEvent({required this.id, required this.reason});
  final String id;
  final String reason;
  @override
  List<Object> get props => [id, reason];
}

class EmergencyCancelEvent extends CreditClassEvent {
  const EmergencyCancelEvent({required this.id, required this.reason});
  final String id;
  final String reason;
  @override
  List<Object> get props => [id, reason];
}

class UpcomingCreditSloteEvent extends CreditClassEvent {
  const UpcomingCreditSloteEvent({required this.id});
  final int id;
  @override
  List<Object> get props => [id];
}

class GetCreditClassNoteEvent extends CreditClassEvent {
  const GetCreditClassNoteEvent({required this.classId});
  final String classId;
  @override
  List<Object> get props => [classId];
}
