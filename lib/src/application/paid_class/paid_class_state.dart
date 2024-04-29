part of 'paid_class_bloc.dart';

class PaidClassState extends Equatable {
  const PaidClassState(
      {this.status = const StatusInitial(),
      this.slotDetails = const PaidClassSlotModel(),
      this.slotStatus = const StatusInitial(),
      this.bookStatus = const StatusInitial(),
      this.paidClassList = const <PaidClass>[],
      this.cancelStatus = const StatusInitial(),
      this.upcomingSlotStatus = const StatusInitial(),
      this.paidSloteDetails = const UpcomingPaidSloteModel(),
      this.checkPaidStatus = const StatusInitial(),
      this.checPaidClassData = const CheckPaidClass(),
      this.paidWebhookStatus = const StatusInitial(),
      this.completedClassNote = const CompletedNoteModel()});
  final Status status;
  final Status slotStatus;
  final Status bookStatus;
  final PaidClassSlotModel slotDetails;
  final List<PaidClass> paidClassList;
  final Status cancelStatus;
  final Status upcomingSlotStatus;
  final UpcomingPaidSloteModel paidSloteDetails;
  final Status checkPaidStatus;
  final CheckPaidClass checPaidClassData;
  final Status paidWebhookStatus;
  final CompletedNoteModel completedClassNote;
  @override
  List<Object> get props => [
        status,
        slotDetails,
        slotStatus,
        bookStatus,
        paidClassList,
        cancelStatus,
        upcomingSlotStatus,
        paidSloteDetails,
        checkPaidStatus,
        checPaidClassData,
        paidWebhookStatus,
        completedClassNote
      ];
  PaidClassState copyWith(
      {Status? status,
      PaidClassSlotModel? slotDetails,
      Status? slotStatus,
      Status? bookStatus,
      List<PaidClass>? paidClassList,
      Status? cancelStatus,
      Status? upcomingSlotStatus,
      UpcomingPaidSloteModel? paidSloteDetails,
      Status? checkPaidStatus,
      CheckPaidClass? checPaidClassData,
      Status? paidWebhookStatus,
      CompletedNoteModel? completedClassNote}) {
    return PaidClassState(
        status: status ?? this.status,
        slotDetails: slotDetails ?? this.slotDetails,
        slotStatus: slotStatus ?? this.slotStatus,
        bookStatus: bookStatus ?? this.bookStatus,
        paidClassList: paidClassList ?? this.paidClassList,
        cancelStatus: cancelStatus ?? this.cancelStatus,
        upcomingSlotStatus: upcomingSlotStatus ?? this.upcomingSlotStatus,
        paidSloteDetails: paidSloteDetails ?? this.paidSloteDetails,
        checkPaidStatus: checkPaidStatus ?? this.checkPaidStatus,
        checPaidClassData: checPaidClassData ?? this.checPaidClassData,
        paidWebhookStatus: paidWebhookStatus ?? this.paidWebhookStatus,
        completedClassNote: completedClassNote ?? this.completedClassNote);
  }
}
