part of 'slot_booking_bloc.dart';

class SlotBookingState extends Equatable {
  const SlotBookingState(
      {this.status = const StatusInitial(),
      this.planList = const <Plan>[],
      this.slotList = const <Slote>[],
      this.feeDetails = const FeeDetailsModel(),
      this.feeDetailStatus = const StatusInitial(),
      this.slotBookingStatus = const StatusInitial()});
  final Status status;
  final Status feeDetailStatus;
  final Status slotBookingStatus;
  final List<Plan> planList;
  final List<Slote> slotList;
  final FeeDetailsModel feeDetails;
  @override
  List<Object> get props => [
        status,
        planList,
        slotList,
        feeDetails,
        feeDetailStatus,
        slotBookingStatus
      ];
  SlotBookingState copyWith(
      {Status? status,
      List<Plan>? planList,
      List<Slote>? slotList,
      FeeDetailsModel? feeDetails,
      Status? feeDetailStatus,
      Status? slotBookingStatus}) {
    return SlotBookingState(
        status: status ?? this.status,
        planList: planList ?? this.planList,
        slotList: slotList ?? this.slotList,
        feeDetailStatus: feeDetailStatus ?? this.feeDetailStatus,
        feeDetails: feeDetails ?? this.feeDetails,
        slotBookingStatus: slotBookingStatus ?? this.slotBookingStatus);
  }
}
