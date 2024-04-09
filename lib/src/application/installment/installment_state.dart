part of 'installment_bloc.dart';

class InstallmentState extends Equatable {
  const InstallmentState(
      {this.status = const StatusInitial(),
      this.installmentList = const <Installment>[],
      this.pendingInstallment = const <PaymentInstallment>[],
      this.pendingstatus = const StatusInitial()});
  final Status status;
  final List<Installment> installmentList;
  final List<PaymentInstallment> pendingInstallment;
  final Status pendingstatus;
  @override
  List<Object> get props =>
      [status, installmentList, pendingInstallment, pendingstatus];
  InstallmentState copyWith(
      {Status? status,
      List<Installment>? installmentList,
      List<PaymentInstallment>? pendingInstallment,
      Status? pendingstatus}) {
    return InstallmentState(
        status: status ?? this.status,
        installmentList: installmentList ?? this.installmentList,
        pendingInstallment: pendingInstallment ?? this.pendingInstallment,
        pendingstatus: pendingstatus ?? this.pendingstatus);
  }
}
