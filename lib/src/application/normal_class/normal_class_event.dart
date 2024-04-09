part of 'normal_class_bloc.dart';

sealed class NormalClassEvent extends Equatable {
  const NormalClassEvent();

  @override
  List<Object> get props => [];
}

class UpcomingClassEvent extends NormalClassEvent {
  const UpcomingClassEvent();

  @override
  List<Object> get props => [];
}

class GetCanceledClassEvent extends NormalClassEvent {
  const GetCanceledClassEvent();

  @override
  List<Object> get props => [];
}

class CompletedClassEvent extends NormalClassEvent {
  const CompletedClassEvent();

  @override
  List<Object> get props => [];
}

class CancelClassEvent extends NormalClassEvent {
  const CancelClassEvent({required this.date, required this.reason});
  final String date;
  final String reason;
  @override
  List<Object> get props => [date, reason];
}

class CancelMulitpleClassEvent extends NormalClassEvent {
  const CancelMulitpleClassEvent(
      {required this.fromDate, required this.reason, required this.toDate});
  final String fromDate;
  final String toDate;
  final String reason;
  @override
  List<Object> get props => [fromDate, reason, toDate];
}

class GetCompletedClassNoteEvent extends NormalClassEvent {
  const GetCompletedClassNoteEvent({required this.classId});
  final String classId;
  @override
  List<Object> get props => [classId];
}

class EmergencyCancelEvent extends NormalClassEvent {
  const EmergencyCancelEvent({required this.date, required this.reason});
  final String date;
  final String reason;
  @override
  List<Object> get props => [date, reason];
}
