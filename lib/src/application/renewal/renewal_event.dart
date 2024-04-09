part of 'renewal_bloc.dart';

sealed class RenewalEvent extends Equatable {
  const RenewalEvent();

  @override
  List<Object> get props => [];
}

class GetRenewalPlansEvent extends RenewalEvent {
  const GetRenewalPlansEvent();
  @override
  List<Object> get props => [];
}

class GetRenewalFeeDetailsEvent extends RenewalEvent {
  final String months;
  const GetRenewalFeeDetailsEvent({required this.months});
  @override
  List<Object> get props => [months];
}

class SendRenewalRequestEvent extends RenewalEvent {
  const SendRenewalRequestEvent({required this.params});
  final PmSendRenewRequestModel params;
  @override
  List<Object> get props => [params];
}

class CleanDataEvent extends RenewalEvent {
  const CleanDataEvent();
  @override
  List<Object> get props => [];
}

class GetRenewalFeesEvent extends RenewalEvent {
  const GetRenewalFeesEvent();
  @override
  List<Object> get props => [];
}

class CheckRenewalEvent extends RenewalEvent {
  const CheckRenewalEvent();
  @override
  List<Object> get props => [];
}
