part of 'normal_class_bloc.dart';

class NormalClassState extends Equatable {
  const NormalClassState(
      {this.upcomingClassStatus = const StatusInitial(),
      this.cancelClassStatus = const StatusInitial(),
      this.completedClassStatus = const StatusInitial(),
      this.status = const StatusInitial(),
      this.cancelledClassList = const <CancelledClass>[],
      this.completedClassList = const <CompletedClass>[],
      this.upcomingClassList = const <UpcomingClass>[],
      this.completedClassNote = const CompletedNoteModel(),
      this.emergencyCancelData = const EmergencyCancelModel()});
  final Status upcomingClassStatus;
  final Status cancelClassStatus;
  final Status completedClassStatus;
  final Status status;
  final List<CancelledClass> cancelledClassList;
  final List<CompletedClass> completedClassList;
  final List<UpcomingClass> upcomingClassList;
  final CompletedNoteModel completedClassNote;
  final EmergencyCancelModel emergencyCancelData;
  @override
  List<Object> get props => [
        upcomingClassStatus,
        cancelClassStatus,
        completedClassStatus,
        status,
        cancelledClassList,
        completedClassList,
        upcomingClassList,
        completedClassNote,
        emergencyCancelData
      ];
  NormalClassState copyWith(
      {Status? upcomingClassStatus,
      Status? cancelClassStatus,
      Status? status,
      Status? completedClassStatus,
      List<CancelledClass>? cancelledClassList,
      List<CompletedClass>? completedClassList,
      List<UpcomingClass>? upcomingClassList,
      CompletedNoteModel? completedClassNote,
      EmergencyCancelModel? emergencyCancelData}) {
    return NormalClassState(
        status: status ?? this.status,
        cancelClassStatus: cancelClassStatus ?? this.cancelClassStatus,
        completedClassStatus: completedClassStatus ?? this.completedClassStatus,
        upcomingClassStatus: upcomingClassStatus ?? this.upcomingClassStatus,
        cancelledClassList: cancelledClassList ?? this.cancelledClassList,
        completedClassList: completedClassList ?? this.completedClassList,
        upcomingClassList: upcomingClassList ?? this.upcomingClassList,
        completedClassNote: completedClassNote ?? this.completedClassNote,
        emergencyCancelData: emergencyCancelData ?? this.emergencyCancelData);
  }
}
