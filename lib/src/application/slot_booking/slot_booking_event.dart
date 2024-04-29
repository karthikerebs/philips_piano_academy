part of 'slot_booking_bloc.dart';

sealed class SlotBookingEvent extends Equatable {
  const SlotBookingEvent();

  @override
  List<Object> get props => [];
}

class GetPlansEvent extends SlotBookingEvent {
  const GetPlansEvent();
  @override
  List<Object> get props => [];
}

class GetSlotsEvent extends SlotBookingEvent {
  final String param;
  const GetSlotsEvent({required this.param});
  @override
  List<Object> get props => [param];
}

class BookingSlotEvent extends SlotBookingEvent {
  final PmSlotBookingModel params;
  const BookingSlotEvent({required this.params});
  @override
  List<Object> get props => [params];
}

class GetFeeDetailsEvent extends SlotBookingEvent {
  final PmGetFeeDetailsModel params;
  const GetFeeDetailsEvent({required this.params});
  @override
  List<Object> get props => [params];
}

class CleanFeeDetailsEvent extends SlotBookingEvent {
  const CleanFeeDetailsEvent();

  @override
  List<Object> get props => [];
}

class SlotBookWebhookEvent extends SlotBookingEvent {
  const SlotBookWebhookEvent({required this.params});
  final PmSloteBookWebhook params;
  @override
  List<Object> get props => [params];
}
