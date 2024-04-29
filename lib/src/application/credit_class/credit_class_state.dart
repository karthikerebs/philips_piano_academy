part of 'credit_class_bloc.dart';

class CreditClassState extends Equatable {
  const CreditClassState(
      {this.status = const StatusInitial(),
      this.creditClasses = const <CreditClass>[],
      this.slotList = const <Slote>[],
      this.bookStatus = const StatusInitial(),
      this.slotStatus = const StatusInitial(),
      this.cancelStatus = const StatusInitial(),
      this.upcomingSlotStatus = const StatusInitial(),
      this.dateAndSlotList = const <DatesAndAvailableSlote>[],
      this.emergencyCancelData = const EmergencyCancelModel(),
      this.completedClassNote = const CompletedNoteModel()});
  final Status status;
  final List<CreditClass> creditClasses;
  final List<Slote> slotList;
  final Status bookStatus;
  final Status slotStatus;
  final Status cancelStatus;
  final Status upcomingSlotStatus;
  final List<DatesAndAvailableSlote> dateAndSlotList;
  final EmergencyCancelModel emergencyCancelData;
  final CompletedNoteModel completedClassNote;
  @override
  List<Object> get props => [
        status,
        creditClasses,
        slotList,
        bookStatus,
        slotStatus,
        cancelStatus,
        upcomingSlotStatus,
        dateAndSlotList,
        emergencyCancelData,
        completedClassNote
      ];
  CreditClassState copyWith(
      {Status? status,
      List<CreditClass>? creditClasses,
      List<Slote>? slotList,
      Status? slotStatus,
      Status? bookStatus,
      Status? cancelStatus,
      Status? upcomingSlotStatus,
      List<DatesAndAvailableSlote>? dateAndSlotList,
      EmergencyCancelModel? emergencyCancelData,
      CompletedNoteModel? completedClassNote}) {
    return CreditClassState(
        status: status ?? this.status,
        creditClasses: creditClasses ?? this.creditClasses,
        slotList: slotList ?? this.slotList,
        bookStatus: bookStatus ?? this.bookStatus,
        slotStatus: slotStatus ?? this.slotStatus,
        cancelStatus: cancelStatus ?? this.cancelStatus,
        upcomingSlotStatus: upcomingSlotStatus ?? this.upcomingSlotStatus,
        dateAndSlotList: dateAndSlotList ?? this.dateAndSlotList,
        emergencyCancelData: emergencyCancelData ?? this.emergencyCancelData,
        completedClassNote: completedClassNote ?? this.completedClassNote);
  }
}
