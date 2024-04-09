part of 'installment_bloc.dart';

sealed class InstallmentEvent extends Equatable {
  const InstallmentEvent();

  @override
  List<Object> get props => [];
}

class GetInstallmentListEvent extends InstallmentEvent {
  const GetInstallmentListEvent();

  @override
  List<Object> get props => [];
}

class GetPendingInstallmentListEvent extends InstallmentEvent {
  const GetPendingInstallmentListEvent();

  @override
  List<Object> get props => [];
}
